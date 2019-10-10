class AddPopulationIdToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :population_id, :integer
    add_index :search_histories, :population_id
  end
end
