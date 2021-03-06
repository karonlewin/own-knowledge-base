# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @reviews = Review.today_reviews(current_user.id)
  end
end
