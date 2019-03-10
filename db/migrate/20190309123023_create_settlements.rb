class CreateSettlements < ActiveRecord::Migration[5.1]
  def change
    create_table :settlements do |t|
      t.datetime :title_registered_date
      t.datetime :estimated_settlement_date
      t.datetime :planned_settlement_date
      t.datetime :final_settlement_date
      t.string :funds_type
      t.string :broker
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
