class SectionController < ApplicationController
  def default
    render action: "show", section: "home"
  end

  def show
    @section = Section.find_by(slug: params[:section])
  end
end
