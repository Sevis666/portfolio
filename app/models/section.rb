class Section < ActiveRecord::Base
  has_many :subsections
  has_many :posts
end
