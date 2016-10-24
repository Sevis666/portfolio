class Subsection < ActiveRecord::Base
  has_many :posts

  @@posts_by_page = 1

  def has_image?
    not (image_name.nil? || image_name == "")
  end

  def fetch_posts(offset = nil, length = @@posts_by_page)
    offset = offset ? offset.to_i : 0
    case display
    when "all_posts"
      Post.where(section_id: section_id, subsection_id: id).order(creation_date: :asc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    when "latest_posts"
      Post.where(section_id: section_id, subsection_id: id).order(creation_date: :desc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    else
      Post.where(section_id: section_id, subsection_id: id).order(creation_date: :asc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    end
  end

  def fetch_next_posts(offset = nil)
    offset = offset ? offset.to_i : 0
    fetch_posts(offset + 1, @@posts_by_page)
  end

  def link(with_offset: nil)
    with_offset = with_offset ? with_offset.to_i : 0
    link = '/' + Section.find(section_id).slug + '/' + slug
    link += '?page=' + with_offset.to_s if with_offset > 0
    link
  end

  def link_to_next_page(page_number)
    page_number ||= 0
    link(with_offset: page_number.to_i + 1)
  end

  def link_to_previous_page(page_number)
    page_number ||= 0
    link(with_offset: page_number.to_i - 1)
  end
end
