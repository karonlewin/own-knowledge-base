class Annotation < ApplicationRecord
  include ReviewGenerator
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  belongs_to :user

  scope :by_user_id, ->(user_id) { where(user_id: user_id) }

  after_create :generate_next_review

  def next_review
    reviews.pending.first
  end
end
