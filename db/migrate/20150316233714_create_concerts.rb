class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.datetime :show_date
      t.belongs_to :venue, index: true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
