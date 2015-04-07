class UserController < ApplicationController 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
    render layout: 'simple'
  end
end
