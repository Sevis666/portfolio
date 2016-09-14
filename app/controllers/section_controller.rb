class SectionController < ApplicationController
  @@default_title = 'David ROBIN'
  @@default_subtitle = 'Description'

  def default
    load_renderer
    @section = Section.order(:order).take
    params[:section] = @section.slug
    @title = @@default_title
    @subtitle = @@default_subtitle
    render action: "show"
  end

  def show
    load_renderer
    @section = Section.find_by(slug: params[:section])
    @title = @@default_title
    @subtitle = @@default_subtitle
  end

  def show_subsection
    load_renderer
    @section = Section.find_by(slug: params[:section])
    @post = Post.find_by(section_id: @section.id, subsection_id: nil, slug: params[:subsection])
    if @post
      # This is a direct child of the section, just display it
      @title = @post.name
      render "posts/show"
    end
    @subsection = Subsection.find_by(section_id: @section.id, slug: params[:subsection])
    @title = @subsection.name
  end
end
