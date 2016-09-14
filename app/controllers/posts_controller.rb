class PostsController < ApplicationController
  def show
    load_renderer
    section = Section.find_by(slug: params[:section])
    subsection = Subsection.find_by(slug: params[:subsection])
    @post = Post.find_by(section_id: section.id,
                         subsection_id: subsection.nil? ? nil : subsection.id,
                         slug: params[:post])
  end

  def show_by_category
  end

  def show_by_tag
  end
end
