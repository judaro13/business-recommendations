module ApplicationHelper

  def get_bussines_items(recommender)
    business = []
    if recommender['_source']
      recommender['_source']['items'].each do |val|
        b = Business.where(yid: val['item']['system_id']).first
        unless b
          b = find_business(val['item']['system_id'])['hits']['hits'].first['_source']
        end
        business << [val['value'], b]
      end
    else
      recommender['hits']['hits'].first['_source']['items'].each do |val|
        b = Business.where(yid: val['item']['system_id']).first
        business << [val['value'], b]
      end
    end
    business
  end

  def find_business(id)
    url = "http://maps.sibcolombia.net:9200/yelp/business/_search"
    uri =  URI.parse(url)
    headers = {'Content-Type' => "application/json",  
                         'Accept-Encoding'=> "gzip,deflate",
                         'Accept' => "application/json"}
    data = { "query": { "match": { "business_id": id } } }

    http = Net::HTTP.new(uri.host,uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.post(uri.path,data.to_json,headers)
    JSON.parse(response.body)
  end

  def select_similarity
    if params[:similarity]
      [params[:similarity].capitalize, params[:similarity]]
    else
      ['Pearson','pearson']
    end
  end

  def select_neigborhood
    if params[:neigborhood]
      [params[:neigborhood], params[:neigborhood]]
    else
      [10,10]
    end

  end

  def get_ir_recommender_result(result=nil)
    result['hits']['hits'].first['_source']['evaluation']
  end

  def get_rsme_recomender_result(result=nil)
    result['hits']['hits'].first['_source']['evaluation']
  end
end
