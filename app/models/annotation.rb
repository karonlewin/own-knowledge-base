class Annotation < ApplicationRecord
  include ReviewGenerator
  has_many :reviews, as: :reviewable
  after_create :generate_reviews
end
