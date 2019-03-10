class AddPropertyTypeToSettlement < ActiveRecord::Migration[5.1]
  def change
    add_column :settlements, :property_type, :string
  end
end
