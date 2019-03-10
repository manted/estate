class AddEstateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :estate, :string
    add_column :projects, :client_name, :string
    add_column :projects, :solicitor, :string
    add_column :projects, :builder, :string
    add_column :projects, :firb, :boolean
    add_column :projects, :property_status, :string
  end
end
