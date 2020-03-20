# frozen_string_literal: true

class SettingUserToEarlierAnnotations < ActiveRecord::Migration[5.1]
  def change
    user = User.first
    Annotation.all.each do |annotation|
      annotation.update(user: user)
    end
  end
end
