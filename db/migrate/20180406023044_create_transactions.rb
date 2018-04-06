class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :date
      t.references :user, index: true, foreign_key: true
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
