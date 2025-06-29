# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :avatar
      t.datetime :email_confirmed_at
      t.string :email_confirmation_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.datetime :last_sign_in_at
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :email_confirmation_token, unique: true
    add_index :users, :password_reset_token, unique: true
  end
end
