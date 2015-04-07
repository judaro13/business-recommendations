class UserController < ApplicationController 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 28)
  end

  def show
    @user = User.find(params[:id])
    review = Review.where(user_id: @user.yid).pluck(:business_id)
    @business = Business.where("yid IN (?)", review)

    render layout: 'simple'
  end
end
