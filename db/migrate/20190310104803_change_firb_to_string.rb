class ChangeFirbToString < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :firb, :string
  end
end
