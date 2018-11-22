class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  scope :pending, -> { where(done: nil) }

  def self.today_reviews
    pending.where("date < ?", DateTime.now.beginning_of_day + 1.days)
  end

  def mark_as_done
    update_attribute(:done, true)
    reviewable.generate_next_review
  end
end
