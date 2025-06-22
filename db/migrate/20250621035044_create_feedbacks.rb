class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.integer :product_id
      t.integer :rating

      t.timestamps
    end
  end
end
