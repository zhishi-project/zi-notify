class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :slack_id
      t.string :slack_name
      t.integer :zhishi_id
      t.string :zhishi_name

      t.timestamps null: false
    end
  end
end
