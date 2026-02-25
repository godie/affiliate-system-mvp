class CreateAffiliateDomains < ActiveRecord::Migration[8.0]
  def change
    create_table :affiliate_domains do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.string :domain
      t.string :verification_method
      t.string :verification_token
      t.datetime :verified_at
      t.string :status

      t.timestamps
    end
  end
end
