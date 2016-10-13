require 'digest/sha1'

class AdminController < ApplicationController
  def main
    @title = "Admin page"
    check_authenticity_token or redirect_to action: "give_token"
  end

  def give_token
    @title = "Get a token"
    if request.post?
      if check_key(params[:key])
        cookies.permanent[:sevis_token] = token_from_key(params[:key])
        redirect_to action: "main"
      else
        @error = "Access denied"
      end
    end
  end

  def reload_structure
    check_authenticity_token or redirect_to action: "give_token"
    sc = StructureController.new
    sc.request = request
    sc.response = response
    sc.reload
    render nothing: true, status: 200
  end

  private
  def check_authenticity_token
    cookies.permanent[:sevis_token] == token_from_key(get_admin_key)
  end

  def token_from_key(key)
    Digest::SHA1.hexdigest(key)
  end

  def check_key(string)
    string == get_admin_key
  end

  def get_admin_key
    File.read(Rails.root.to_s + "/data/.adminkey").chomp
  end
end
