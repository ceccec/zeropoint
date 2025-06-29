# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.string :status, default: 'draft', null: false
      t.integer :views, default: 0
      t.string :slug
      t.timestamps
    end
    add_index :posts, :slug, unique: true
    add_index :posts, :status
  end
end
