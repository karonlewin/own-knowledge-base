# frozen_string_literal: true

class AddReviewableToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :reviewable_id, :integer
    add_column :reviews, :reviewable_type, :string
  end
end
