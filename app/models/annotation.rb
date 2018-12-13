class Annotation < ApplicationRecord
  include ReviewGenerator
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category

  after_create :generate_next_review

  def next_review
    reviews.pending.first
  end
end
