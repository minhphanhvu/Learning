class CreateEmbeddeds < ActiveRecord::Migration[7.0]
  def change
    create_table :embeddeds do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :token
      t.string :controller
      t.string :action

      t.timestamps
    end
    add_index :embeddeds, :token, unique: true
  end
end
