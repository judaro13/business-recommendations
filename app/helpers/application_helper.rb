module ApplicationHelper

  def get_bussines_items(recommender)
    business = []
    if recommender['_source']
      recommender['_source']['items'].each do |val|
        business << [val['value'], 
          Business.where(yid: val['item']['system_id']).first]
      end
    else
      recommender['hits']['hits'].first['_source']['items'].each do |val|
        business << [val['value'], 
          Business.where(yid: val['item']['system_id']).first]
      end
    end
    business
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
