class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :from
      t.string :to
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
