class Section < ActiveRecord::Base
  has_many :subsections
  has_many :posts

  @@posts_by_page = 6

  def has_subtitle?
    not subtitle.nil?
  end

  def fetch_posts(offset = nil, length = @@posts_by_page)
    offset = offset ? offset.to_i : 0
    case display
    when "global:all_posts"
      Post.order(creation_date: :asc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    when "global:latest_posts"
      Post.order(creation_date: :desc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    when "all_posts"
      Post.where(section_id: id).order(creation_date: :asc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    when "latest_posts"
      Post.where(section_id: id).order(creation_date: :desc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    else
      Post.where(section_id: id, subsection_id: nil).order(creation_date: :asc, slug: :asc)
        .limit(length).offset(@@posts_by_page * offset)
    end
  end

  def fetch_next_posts(offset = nil)
    offset = offset ? offset.to_i : 0
    fetch_posts(offset + 1, @@posts_by_page / 2)
  end

  def link(with_offset: nil)
    with_offset = with_offset ? with_offset.to_i : 0
    link = '/' + slug
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
