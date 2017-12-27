class AddResultToCalculators < ActiveRecord::Migration[5.1]
  def change
    add_column :calculators, :result, :float
  end
end
