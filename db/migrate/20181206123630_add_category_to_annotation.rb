class AddCategoryToAnnotation < ActiveRecord::Migration[5.1]
  def change
    add_reference :annotations, :category, foreign_key: true
  end
end
