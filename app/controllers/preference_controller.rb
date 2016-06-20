class PreferenceController < ApplicationController
  def index
    user = User.find_by(zhishi_id: preference_params[:id])
    if user
      render json: user.preference.as_json
    else
      head 404
    end
  end

  def update
    pref_params = preference_params
    user = User.find_by(zhishi_id: pref_params.delete(:id))

    if user && user.preference.update(pref_params)
      head 202
    else
      head 400
    end
  end

  def preference_params
    params.permit(:id, :slack, :email)
  end
end