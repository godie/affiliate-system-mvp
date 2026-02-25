class CreateClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :clicks do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.references :affiliate_domain, null: false, foreign_key: true
      t.string :referral_code
      t.string :ip
      t.text :user_agent
      t.text :referer
      t.string :request_id
      t.datetime :clicked_at
      t.jsonb :raw_metadata

      t.timestamps
    end
  end
end
