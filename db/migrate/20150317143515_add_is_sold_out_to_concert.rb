class AddIsSoldOutToConcert < ActiveRecord::Migration
  def change
  	add_column :concerts, :is_sold_out, :boolean
  end
end
