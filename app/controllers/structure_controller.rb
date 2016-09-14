class StructureController < ApplicationController
  def list_categories
    @categories = Category.all.order(:name)
  end

  def list_tags
    @tags = Tag.all.order(:name)
  end

  def reload
    Dir.chdir(Rails.root.to_s + "/data")
    store_sections(read_sections)

    Section.find_each do |s|
      store_posts(s, nil, read_posts(s.slug))
      s.subsections.each do |sub|
        store_posts(s, sub, read_posts(s.slug + '/' + sub.slug))
      end
    end

    render nothing: true, status: 200
  end

  def print_structure
    Section.find_each {|s| p s }
    puts
    Subsection.find_each {|s| p s }
    puts
    Post.find_each {|s| p s }
  end

  private
  def read_sections
    f = File.open("structure.xml")
    Hash.from_xml(f.read)["structure"]["section"]
  end

  def store_sections(sections)
    sections.each do |s|
      unless Section.where(slug: s["slug"]).count > 0
        section = Section.new(name: s["name"], slug: s["slug"],
                              order: s["order"].to_i,
                              display: s["display"])
        section.save
      else
        section = Section.find_by(slug: s["slug"])
      end
      if s["subsections"]
        store_subsections(section, s["subsections"]["subsection"])
      end
    end
  end

  def store_subsections(section, subsections)
    subsections.each do |sub|
      unless Subsection.where(section_id: section.id).where(slug: sub["slug"]).count > 0
        Subsection.new(section_id: section.id, name: sub["name"],
                       slug: sub["slug"], display: sub["display"])
          .save
      end
    end
  end

  def read_posts(folder)
    Dir.glob(folder + '/*.xml').map {|s| s[0..-5]}
  end

  def store_posts(section, subsection, posts)
    posts.each do |post|
      p = post.split('/')
      slug = p.last
      path = p[0..-2].join('/')

      info = Hash.from_xml(File.read(post + '.xml'))["post"]

      str = info["creation_date"] || info["cd"]
      cd = str.nil? ? Date.today : Date.parse(str)
      str = info["last_modification_date"] || info["lmd"]
      lmd = str.nil? ? Date.today : Date.parse(str)

      p = Post.find_by(slug: slug, path: path) ||
          Post.new(slug: slug, path: path, section_id: section.id, subsection_id: subsection.nil? ? nil : subsection.id)
      p.name = info["name"]
      p.creation_date = cd
      p.last_modification_date = lmd
      p.save

      unless info["related_posts"].nil?
        related = info["related_posts"]["post"]
        related = [related] unless related.is_a? Array
        related.each do |rp|
          r = Post.find_by_path(rp)
          RelatedPost.new(post_id: p.id, related_post_id: r.id)
            .save unless r.nil?
        end
      end
    end
  end
end
