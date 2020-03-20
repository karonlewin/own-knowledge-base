# frozen_string_literal: true

class AddUserToAnnotation < ActiveRecord::Migration[5.1]
  def change
    add_reference :annotations, :user, foreign_key: true
  end
end
