class SettingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[reset_account destroy_account]

  def api_cli; end

  def communication_preferences; end

  def donations
    @payments = current_user.donation_payments.includes(:subscription)
  end

  def reset_account
    User::ResetAccount.(current_user) if params[:handle] == current_user.handle

    render json: {
      links: {
        home: Exercism::Routes.root_url
      }
    }
  end

  def destroy_account
    User::DestroyAccount.(current_user) if params[:handle] == current_user.handle

    render json: {
      links: {
        home: Exercism::Routes.root_url
      }
    }
  end
end
