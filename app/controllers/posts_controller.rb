class PostsController < ApplicationController
  def show
    category = Catgory.find_by(slug: params[:category])
    @post = Post.find_by(category_id: category.id, slug: params[:post])
  end

  def show_by_category
  end

  def show_by_tag
  end
end
