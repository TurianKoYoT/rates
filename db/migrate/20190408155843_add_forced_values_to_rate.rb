class AddForcedValuesToRate < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :forced_value, :float
    add_column :rates, :forced_until, :datetime
  end
end
