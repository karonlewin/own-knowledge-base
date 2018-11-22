class DashboardController < ApplicationController

  def index
    @reviews = Review.today_reviews
  end
end
