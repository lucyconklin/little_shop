class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest

      t.timestamps
    end
    add_index :customers, :email, :unique => true
  end
end
