class Annotation < ApplicationRecord
  include ReviewGenerator
  has_many :reviews, as: :pendable
  after_create :generate_reviews
end
