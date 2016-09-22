class Section < ActiveRecord::Base
  has_many :subsections
  has_many :posts

  def fetch_posts
    case display
    when "global:all_posts"
      Post.order(creation_date: :asc).limit(12)
    when "global:latest_posts"
      Post.order(creation_date: :desc).limit(12)
    when "all_posts"
      Post.where(section_id: id).order(creation_date: :asc)
    when "latest_posts"
      Post.where(section_id: id).order(creation_date: :desc)
    else
      Post.where(section_id: id, subsection_id: nil)
    end
  end
end
