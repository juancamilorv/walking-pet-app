class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :state
      t.integer :price
      t.time :started_at
      t.time :finished_at
      t.integer :rating
      t.text :review
      t.datetime :schedule
      t.references :pet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
