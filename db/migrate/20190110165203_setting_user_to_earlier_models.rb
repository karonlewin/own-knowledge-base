# frozen_string_literal: true

class SettingUserToEarlierModels < ActiveRecord::Migration[5.1]
  def change
    user = User.first

    Review.all.each do |review|
      review.update(user: user)
    end

    Category.all.each do |category|
      category.update(user: user)
    end
  end
end
