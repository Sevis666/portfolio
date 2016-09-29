class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def self.find_by_path(path)
    path = path.split('/')
    post = nil
    case path.size
    when 3
      section = Section.find_by(slug: path[0]) or return nil
      subsection = Subsection.find_by(section_id: section.id, slug: path[1]) or return nil
      post = Post.find_by(section_id: section.id, subsection_id: subsection.id, slug: path[2])
    when 2
      section = Section.find_by(slug: path[0]) or return nil
      post = Post.find_by(section_id: section.id, subsection_id: nil, slug: path[1])
    end
    post
  end

  def link
    link = '/' + Section.find(section_id).slug
    link += '/' + Subsection.find(subsection_id).slug unless subsection_id.nil?
    link += '/' + slug
    link
  end

  def related_posts
    ActiveRecord::Base.connection
      .execute("SELECT p.* FROM posts p INNER JOIN related_posts r ON r.related_post_id = p.id WHERE r.post_id = #{id}")
      .map {|p| Post.new(p) }
  end

  def has_image?
    not (image_name.nil? || image_name == "")
  end
end
