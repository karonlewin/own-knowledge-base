class DashboardController < ApplicationController

  def index
    @reviews = Review.by_user_id(current_user.id).today_reviews
  end
end
