class AddCardToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :stripe_id, :string
    add_column :customers, :stripe_checkout_id, :string
    add_column :customers, :card_brand, :string
    add_column :customers, :card_last4, :string
    add_column :customers, :card_exp_month, :string
    add_column :customers, :card_exp_year, :string
  end
end
