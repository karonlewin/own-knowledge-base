class DashboardController < ApplicationController

  def index
    @reviews = Review.by_user_id(current_user.id).today_reviews
  end

  def testing_email
    ReviewMailer.today_reviews.deliver_now
  end
end
