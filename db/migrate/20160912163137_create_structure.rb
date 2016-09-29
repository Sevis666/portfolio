class CreateStructure < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :order
      t.string :slug
      t.string :name
      t.string :display
    end

    create_table :subsections do |t|
      t.belongs_to :section
      t.string :slug
      t.string :name
      t.string :display
      t.string :image_name
    end

    create_table :tags do |t|
      t.string :slug
      t.string :name
    end

    create_table :categories do |t|
      t.string :slug
      t.string :name
    end

    create_table :posts do |t|
      t.belongs_to :category
      t.belongs_to :section
      t.belongs_to :subsection
      t.string :slug
      t.string :name
      t.date :creation_date
      t.date :last_modification_date
      t.string :path
      t.string :image_name
    end

    create_table :related_posts do |t|
      t.integer :post_id
      t.integer :related_post_id
    end

    create_table :posts_tags, id: false do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
    end
  end
end
