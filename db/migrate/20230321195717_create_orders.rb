class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_id
      t.decimal :total, precision: 10, scale: 2
      t.datetime :payment_date

      t.timestamps
    end
  end
end
