class AddExpressionToCalculators < ActiveRecord::Migration[5.1]
  def change
    add_column :calculators, :expression, :string
  end
end
