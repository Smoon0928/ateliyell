class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def top
    @products = Product.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end
end
