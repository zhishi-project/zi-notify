class PreferenceController < ApplicationController
  def update
    pref_params = preference_params
    user = User.find_by(zhishi_id: pref_params.delete(:zhishi_id))

    if user && user.preference.update(pref_params)
      head 202
    else
      head 400
    end
  end

  def preference_params
    params.permit(:slack, :email, :zhishi_id)
  end
end