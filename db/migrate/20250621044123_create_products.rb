class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, limit: 20

      t.timestamps
    end
  end
end
