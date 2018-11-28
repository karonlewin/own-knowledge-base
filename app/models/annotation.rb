class Annotation < ApplicationRecord
  include ReviewGenerator
  has_many :reviews, as: :reviewable

  after_create :generate_next_review

  def next_review
    reviews.pending.first
  end
end
