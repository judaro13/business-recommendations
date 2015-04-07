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

    if params[:similarity] == 'loglike'
      if params[:neigborhood] == '20'
        @collaborative = "yelp_recommend/recommendation2/_taste/user/#{@user.yid}"
      else
        @collaborative = "yelp_recommend/recommendation/_taste/user/#{@user.yid}"
      end
    else
      if params[:neigborhood] == '20'
        @collaborative = "yelp_recommend/recommendation4/_taste/user/#{@user.yid}"
      else
        @collaborative = "yelp_recommend/recommendation3/_taste/user/#{@user.yid}"
      end
    end

    if params[:sigma] == 2
      @svd = "yelp_recommend/recommendation6/_taste/user/#{@user.yid}"
    else
      @svd = "yelp_recommend/recommendation5/_taste/user/#{@user.yid}"
    end

    @hibrid = "yelp_recommend/recommendation7/_taste/user/#{@user.yid}"


    @hibrid = JSON.parse('{
  "took" : 1,
  "timed_out" : false,
  "hits" : {
    "total" : 1,
    "max_score" : 0.0,
    "hits" : [ {
      "_index" : "yelp_recommend",
      "_type" : "recommendation",
      "_id" : "AUyKdOx1OoWbrzST6OC1",
      "_score" : "NaN",
      "_source" : {
        "user" : {
          "@timestamp" : "2015-04-05T15:29:06.181Z",
          "user_id" : 13,
          "system_id" : "JPPhyFE-UE453zA6K0TVgw"
        },
        "items" : [ {
          "value" : 5.0,
          "item" : {
            "@timestamp" : "2015-04-05T15:29:47.980Z",
            "item_id" : 148,
            "system_id" : "XWLtYPhCpHht5Zn52zp3-Q"
          }
        }, {
          "value" : 4.6660285,
          "item" : {
            "@timestamp" : "2015-04-05T15:32:00.131Z",
            "item_id" : 531,
            "system_id" : "yWVY1Bq19lDxu3BP7_96EQ"
          }
        }, {
          "value" : 4.502543,
          "item" : {
            "@timestamp" : "2015-04-05T15:29:21.716Z",
            "item_id" : 59,
            "system_id" : "LQFWH1AKJlXGmEBlIKsBCw"
          }
        }, {
          "value" : 4.502543,
          "item" : {
            "@timestamp" : "2015-04-05T15:29:21.342Z",
            "item_id" : 56,
            "system_id" : "rdATJvFQK4C73NIQ3zoY3w"
          }
        }, {
          "value" : 4.502349,
          "item" : {
            "@timestamp" : "2015-04-05T15:32:04.446Z",
            "item_id" : 543,
            "system_id" : "4q2nThFVuU3BZoEMkYQ1yg"
          }
        }, {
          "value" : 4.50003,
          "item" : {
            "@timestamp" : "2015-04-05T15:30:37.335Z",
            "item_id" : 321,
            "system_id" : "buVALudg30kgkDusqB3yJw"
          }
        }, {
          "value" : 4.498665,
          "item" : {
            "@timestamp" : "2015-04-05T15:30:54.638Z",
            "item_id" : 377,
            "system_id" : "gFT2yXDXJ1qfuGOSfSU5Bw"
          }
        }, {
          "value" : 4.4983616,
          "item" : {
            "@timestamp" : "2015-04-05T15:30:05.071Z",
            "item_id" : 227,
            "system_id" : "93UCt9OgWYmypZCpXtUu8g"
          }
        }, {
          "value" : 4.4980016,
          "item" : {
            "@timestamp" : "2015-04-05T15:30:03.073Z",
            "item_id" : 215,
            "system_id" : "9NL2GL4jSPVj9SKijH5PqA"
          }
        }, {
          "value" : 4.003366,
          "item" : {
            "@timestamp" : "2015-04-05T15:32:03.381Z",
            "item_id" : 540,
            "system_id" : "Tfysaq2SdZAc5_TyPpuyLA"
          }
        } ],
        "@timestamp" : "2015-04-05T16:41:00.789Z"
      }
    } ]
  }
}')

    render layout: 'simple'
  end
end