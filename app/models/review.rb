class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true

  def mark_as_done
    update_attribute(:done, true)
    reviewable.generate_next_review
  end

end
