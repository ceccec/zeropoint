# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    description 'A registered user'

    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # Add vortex and consciousness fields if needed
    field :vortex_session_id, String, null: true
    field :consciousness_context, String, null: true
  end
end
