module ReviewGenerator
  WEEKLY_REVIEWS = 8
  MONTHLY_REVIEWS = 12

  def generate_reviews
    generate_weekly
    generate_monthly
  end

  def generate_weekly
    review_date = self.created_at

    WEEKLY_REVIEWS.times do
      review_date += 1.weeks
      review = Review.new
      review.reviewable = self
      review.date = review_date
      review.save
    end
  end

  def generate_monthly
    review_date = self.created_at + WEEKLY_REVIEWS.weeks

    MONTHLY_REVIEWS.times do
      review_date += 1.months
      review = Review.new
      review.reviewable = self
      review.date = review_date
      review.save
    end
  end
end
