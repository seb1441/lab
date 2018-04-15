class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.integer :status_cd, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
