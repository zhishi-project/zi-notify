class Preference < ActiveRecord::Base
  belongs_to :user

  def as_json
    super(only: [:slack, :email, :newsletter, :updated_at])
  end
end
