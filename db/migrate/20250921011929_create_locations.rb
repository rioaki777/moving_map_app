class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.datetime :recorded_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
