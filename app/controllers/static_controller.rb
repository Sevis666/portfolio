class StaticController < ApplicationController
  def pgp_key
    render file: "public/7715d3b3.asc"
  end
end
