# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: { message: I18n.t('activerecord.errors.models.comment.attributes.content.blank') },
                      length: { minimum: 2, maximum: 2000 }

  def author_name
    user.full_name
  end
end
