class AddNewsletterToPreference < ActiveRecord::Migration
  def change
    add_column :preferences, :newsletter, :boolean, default: true
  end
end
