Rails.application.routes.draw do
  get "/", to: "section#default"

  get "/public/7715d3b3.asc", to: "static#pgp_key"
  get "/admin", to: "admin#main"
  get "/admin/token", to: "admin#give_token"
  post "/admin/token", to: "admin#give_token"
  get "/admin/reload", to: "admin#reload_structure"

  get "/category", to: "structure#list_categories"
  get "/category/:category", to: "posts#show_by_category"

  get "/tags", to: "structure#list_tags"
  get "/tags/:tag", to: "posts#show_by_tag"

  get "/:section", to: "section#show"
  get "/:section/:subsection", to: "section#show_subsection"
  get "/:section/:subsection/:post", to: "posts#show"
end
