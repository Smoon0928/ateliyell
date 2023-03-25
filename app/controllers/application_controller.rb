class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :set_search
  add_flash_types :success, :info, :warning, :danger
  
  def after_sign_out_path_for(resource)
    about_path
  end
  
  def set_search
    @search = User.ransack(params[:q])
    @search_users = @search.result.page(params[:page])
  end
  
  def authenticate_user_admin!
    # byebug
    if !user_signed_in? && !admin_signed_in?
      redirect_to root_path
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:encrypted_password,:phone_number,:user_name])
  end
end

