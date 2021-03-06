# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: [:mark_as_done]

  def mark_as_done
    @review.mark_as_done
    flash[:notice] = 'Congratulations! Review done.'
    respond_to do |format|
      format.html { redirect_to @review.reviewable }
    end
  end

  def mark_all_reviews_as_done
    Review.today_reviews(current_user.id).each(&:mark_as_done)
    flash[:notice] = 'Congratulations! All reviews done.'
    respond_to do |format|
      format.html { redirect_to dashboard_path }
    end
  end

  def randomize_non_reviewed
    Review.randomize_non_reviewed(current_user.id)
    flash[:notice] = 'Reviews randomized into the next week! Keep going!'
    respond_to do |format|
      format.html { redirect_to dashboard_path }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end
