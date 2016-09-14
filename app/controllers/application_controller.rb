class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def load_renderer
    renderer = Redcarpet::Render::HTML.new(render_options = {})
    @markdown = Redcarpet::Markdown.new(renderer)
  end
end
