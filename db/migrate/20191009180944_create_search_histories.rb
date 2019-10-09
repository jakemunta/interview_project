class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.integer :year
      t.integer :result

      t.timestamps
    end
  end
end
