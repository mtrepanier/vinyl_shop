class AddIsGeneratedToConcert < ActiveRecord::Migration
  def change
  	add_column :concerts, :is_generated, :boolean
  end
end
