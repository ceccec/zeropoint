# frozen_string_literal: true

class ActsAsTaggableOnMigration < ActiveRecord::Migration[7.1]
  def self.up
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.references :tag, foreign_key: true
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true
      t.string :context
      t.datetime :created_at
    end
    add_index :taggings, %i[tag_id taggable_id taggable_type context], name: 'taggings_idx'
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
