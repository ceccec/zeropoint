# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id,
            uniqueness: { scope: :post_id, message: I18n.t('activerecord.errors.models.like.attributes.user_id.taken') }
end
