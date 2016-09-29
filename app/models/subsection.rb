class Subsection < ActiveRecord::Base
  has_many :posts

  def fetch_posts
    case display
    when "all_posts"
      Post.where(section_id: section_id, subsection_id: id).order(creation_date: :asc)
    when "latest_posts"
      Post.where(section_id: section_id, subsection_id: id).order(creation_date: :desc)
    else
      Post.where(section_id: section_id, subsection_id: id)
    end
  end

  def has_image?
    not (image_name.nil? || image_name == "")
  end
end
