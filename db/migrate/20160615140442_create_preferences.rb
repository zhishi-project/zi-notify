class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.boolean :slack, default: true
      t.boolean :email, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
