class CreateConversions < ActiveRecord::Migration[8.0]
  def change
    create_table :conversions do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.references :click, null: false, foreign_key: true
      t.string :external_order_id
      t.integer :amount_cents
      t.string :currency
      t.string :status
      t.datetime :attributed_at
      t.jsonb :raw_metadata

      t.timestamps
    end
  end
end
