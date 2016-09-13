class AddPreferenceForExistingUsers < ActiveRecord::Migration
  def change
    User.find_each do |u|
      u.create_preference
    end
  end
end
