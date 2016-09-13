Rails.application.routes.draw do
  get "/", to: "section#default"

  get "/public/7715d3b3.asc", to: "static#pgp_key"
  get "/reload", to: "structure#reload"

  get "/category", to: "structure#list_categories"
  get "/category/:category", to: "posts#show_by_category"

  get "/tags", to: "structure#list_tags"
  get "/tags/:tag", to: "posts#show_by_tag"

  get "/:section", to: "section#show"
  get "/:section/:post", to: "post#show"
end
