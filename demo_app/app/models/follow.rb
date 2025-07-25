# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id,
            uniqueness: { scope: :followed_id,
                          message: I18n.t('activerecord.errors.models.follow.attributes.follower_id.taken') }
end
