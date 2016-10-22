class PostsController < ApplicationController
  def show
    load_renderer
    section = Section.find_by(slug: params[:section])
    subsection = Subsection.find_by(slug: params[:subsection])
    @post = Post.find_by(section_id: section.id,
                         subsection_id: subsection.nil? ? nil : subsection.id,
                         slug: params[:post])
    @title = @post.name
    @subtitle = @post.printable_creation_date
  end

  def show_by_category
  end

  def show_by_tag
    @title = "David ROBIN"
    @subtitle = "Tag archive"
    @tag = Tag.find_by(slug: params[:tag])
    @posts = Post.joins(:tags).where(tags: {slug: params[:tag]})
  end
end
