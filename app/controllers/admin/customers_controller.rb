class Admin::CustomersController < ApplicationController
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  private
    def customer_params
      params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:email,:user_name,:address,:phone_number,:is_customer_deleted)
    end
end
