# frozen_string_literal: true

class CreateAnnotations < ActiveRecord::Migration[5.1]
  def change
    create_table :annotations do |t|
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
