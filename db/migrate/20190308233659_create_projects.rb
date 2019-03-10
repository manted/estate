class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :lot
      t.string :address
      t.string :office

      t.timestamps
    end
  end
end
