class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :description
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
