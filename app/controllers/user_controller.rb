class UserController < ApplicationController 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 28)
  end

  def show
    @user = User.find(params[:id])
    ids = @user.reviews.pluck(:business_id)
    @business = Business.where("id IN (?)", ids)
    path = 'http://maps.sibcolombia.net:9200/yelp_recommend/'


    if params[:similarity] == 'loglike'
      if params[:neigborhood] == '20'
        @collaborative = "recommendation2/_taste/user/#{@user.yid}"
        @collaborative_rsm = JSON.parse(Net::HTTP.get(URI.parse(path + 'rec1RMSLogLikeNearest20/_search?pretty')))
      else
        @collaborative = "recommendation/_taste/user/#{@user.yid}"
        @collaborative_rsm = JSON.parse(Net::HTTP.get(URI.parse(path + 'rec1RMSLogLikeNearest10/_search?pretty')))
      end
    else
      if params[:neigborhood] == '20'
        @collaborative = "recommendation4/_taste/user/#{@user.yid}"
        @collaborative_rsm =JSON.parse(Net::HTTP.get(URI.parse(path + 'rec1RMSPearsonNearest20/_search?pretty')))
      else
        @collaborative = "recommendation3/_taste/user/#{@user.yid}"
        @collaborative_rsm =JSON.parse(Net::HTTP.get(URI.parse(path + 'rec1RMSPearsonNearest10/_search?pretty')))
      end
    end
    @collaborative_ir = JSON.parse(Net::HTTP.get(URI.parse(path + 'rec1ir/_search?pretty')))

    @svd = "recommendator2/_taste/user/#{@user.yid}"
    @svd_rsm =JSON.parse(Net::HTTP.get(URI.parse(path + 'rec2RMSSVDFeatures100Lambda007Iterations2/_search?pretty')))
    @svd_ir =JSON.parse(Net::HTTP.get(URI.parse(path + 'rec2IRSSVDFeatures100Lambda007Iterations2/_search?pretty')))
    
    @svd = JSON.parse(Net::HTTP.get(URI.parse(path+@svd)))
    @collaborative = JSON.parse(Net::HTTP.get(URI.parse(path+@collaborative)))

    @hibrid = JSON.parse(Net::HTTP.get(URI.parse(path+"recommendator2b/#{@user.yid}?pretty")))
    @hibrid_rsm = JSON.parse(Net::HTTP.get(URI.parse(path + 'rec3RMS/_search?pretty')))
    @hibrid_ir = JSON.parse(Net::HTTP.get(URI.parse(path + 'rec3IRS/_search?pretty')))

    render layout: 'simple'
  end
end