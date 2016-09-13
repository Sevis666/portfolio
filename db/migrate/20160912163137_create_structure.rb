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
    end
  end
end
