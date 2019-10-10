class AddExactMatchToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :exact_match, :boolean
  end
end
