class CreatePayoutItems < ActiveRecord::Migration[8.0]
  def change
    create_table :payout_items do |t|
      t.references :payout, null: false, foreign_key: true
      t.references :conversion, null: false, foreign_key: true
      t.integer :amount_cents

      t.timestamps
    end
  end
end
