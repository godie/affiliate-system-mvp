class CreateOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers do |t|
      t.string :name
      t.string :slug
      t.integer :payout_cents
      t.string :currency
      t.string :status
      t.integer :attribution_window_seconds

      t.timestamps
    end
  end
end
