class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  scope :pending, -> { where(done: nil) }
  scope :by_user_id, -> (user_id) { where(user_id: user_id) }

  def reviewable_type=(class_name)
   super(class_name.constantize.base_class.to_s)
  end

  def self.today_reviews(user_id)
    by_user_id(user_id).pending.where("date < ?", DateTime.now.beginning_of_day + 1.days)
  end

  def mark_as_done
    update_attribute(:done, true)
    reviewable.generate_next_review
  end

  def self.randomize_non_reviewed(user_id)
    shuffled_reviews = today_reviews(user_id).shuffle
    day_counter = 0

    shuffled_reviews.each do |review|
      review.update_attribute(:date, DateTime.now + day_counter.days)
      if day_counter == 6
        day_counter = 0
      else
        day_counter+= 1
      end
    end
  end
end
