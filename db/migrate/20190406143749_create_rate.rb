class CreateRate < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :code, null: false
      t.float :value
    end
  end
end
