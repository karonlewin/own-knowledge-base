module ReviewGenerator
  ReviewGenerator::WEEKLY_REVIEWS = 8
  ReviewGenerator::MONTHLY_REVIEWS = 12
  ReviewGenerator::TOTAL_REVIEWS = WEEKLY_REVIEWS + MONTHLY_REVIEWS


  def generate_next_review
    next_review_date = nil

    if reviews.count == 0
      next_review_date = created_at + 1.weeks
    elsif reviews.count < WEEKLY_REVIEWS
      next_review_date = DateTime.now + 1.weeks
    elsif reviews.count < (WEEKLY_REVIEWS + MONTHLY_REVIEWS)
      next_review_date = DateTime.now + 1.month
    end

    if next_review_date
      Review.create(date: next_review_date, reviewable: self, user: self.user)
    end
  end
end
