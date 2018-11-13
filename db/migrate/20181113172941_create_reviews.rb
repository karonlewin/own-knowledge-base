class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.datetime :date
      t.boolean :done
      t.references :annotation, foreign_key: true

      t.timestamps
    end
  end
end
