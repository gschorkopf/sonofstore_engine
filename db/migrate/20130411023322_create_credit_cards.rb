class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :security_code
      t.integer :expiration_month
      t.integer :expiration_year
      t.references :user

      t.timestamps
    end
    add_index :credit_cards, :user_id
  end
end
