class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :set_search
  

  def after_sign_in_path_for(resource)
    products_path
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end
  
  def set_search
    @search = User.ransack(params[:q])
    @search_users = @search.result.page(params[:page])
  end
  
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:encrypted_password,:phone_number,:user_name])
  end
end

