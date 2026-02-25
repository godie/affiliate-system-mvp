class CreatePayouts < ActiveRecord::Migration[8.0]
  def change
    create_table :payouts do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.datetime :period_start
      t.datetime :period_end
      t.string :status
      t.integer :total_conversions
      t.integer :total_amount_cents
      t.string :currency

      t.timestamps
    end
  end
end
