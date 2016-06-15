User.all.each do |user|
  Preference.create(user: user)
end