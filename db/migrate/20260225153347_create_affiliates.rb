class CreateAffiliates < ActiveRecord::Migration[8.0]
  def change
    create_table :affiliates do |t|
      t.string :name
      t.string :email
      t.string :status
      t.string :referral_code

      t.timestamps
    end
    add_index :affiliates, :referral_code, unique: true
  end
end
