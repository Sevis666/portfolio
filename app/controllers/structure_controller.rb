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
    subsections = [subsections] unless subsections.is_a? Array
    subsections.each do |sub|
      s = Subsection.find_by(section_id: section.id, slug: sub["slug"]) ||
          Subsection.new(section_id: section.id, slug: sub["slug"])
      s.name = sub["name"]
      s.display = sub["display"]
      s.image_name = sub["image_name"]
      s.description = sub["description"]
      s.save
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
          Post.new(slug: slug, path: path, section_id: section.id,
                   subsection_id: subsection.nil? ? nil : subsection.id)
      p.name = info["name"]
      p.image_name = info["image_name"]
      p.creation_date = cd
      p.last_modification_date = lmd
      p.save

      unless info["related_posts"].nil?
        related = info["related_posts"]["post"]
        related = [related] unless related.is_a? Array
        related.each do |rp|
          r = Post.find_by_path(rp)
          unless r.nil?
            previous = RelatedPost.find_by(post_id: p.id, related_post_id: r.id)
            RelatedPost.new(post_id: p.id, related_post_id: r.id)
              .save if previous.nil?
          end
        end
      end

      unless info["tags"].nil?
        tags = info["tags"]["tag"]
        tags = [tags] unless tags.is_a? Array
        tags.each do |tagname|
          tag = Tag.find_by(slug: tagname) || Tag.new(slug: tagname)
          tag.save
          p.tags << tag unless p.tags.include? tag
        end
      end
    end
  end
end
