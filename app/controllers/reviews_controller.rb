class ReviewsController < ApplicationController
  before_action :set_review, only: [:mark_as_done]

  def mark_as_done
    @review.mark_as_done
    flash[:notice] = 'Congratulations! Review done.'
    respond_to do |format|
      format.html { redirect_to  @review.reviewable }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
end
