class CreateLocationViews < ActiveRecord::Migration[8.0]
  def change
    create_table :location_views do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :seconds_viewed, null: false, default: 0

      t.timestamps
    end
  end
end
