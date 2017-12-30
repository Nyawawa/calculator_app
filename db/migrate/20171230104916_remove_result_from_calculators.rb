class RemoveResultFromCalculators < ActiveRecord::Migration[5.1]
  def change
    remove_column :calculators, :result, :float
  end
end
