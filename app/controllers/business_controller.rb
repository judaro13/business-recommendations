class BusinessController < ApplicationController 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @business = Business.all.paginate(:page => params[:page], :per_page => 28)
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews
    render layout: 'simple'
  end
end
