class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string   :name, null: false
      t.string     :url, null: false
      t.references  :post, foreign_key: true
      t.timestamps
    end
  end
end
