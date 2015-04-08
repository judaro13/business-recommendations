module ApplicationHelper

  def get_bussines_items(recommender)
    business = []
    recommender['hits']['hits'].first['_source']['items'].each do |val|
      business << [val['value'], 
        Business.where(yid: val['item']['system_id']).first]
    end
    business
  end

  def get_ir_recommender_result(result=nil)
    result = JSON.parse('{
   "took": 2,
   "timed_out": false,
   "_shards": {
      "total": 5,
      "successful": 5,
      "failed": 0
   },
   "hits": {
      "total": 1,
      "max_score": 1,
      "hits": [
         {
            "_index": "yelp_recommend",
            "_type": "sopas",
            "_id": "AUyWhSBC6HnAo5jpHWyZ",
            "_score": 1,
            "_source": {
               "evaluation": {
                  "precision": 0.028228831725616296,
                  "recall": 0.04523623074915167,
                  "f1": 0.03476389736025976,
                  "target": {
                     "dataUsed": "100%"
                  }
               },
               "@timestamp": "2015-04-08T00:54:09.216Z",
               "evaluator_id": null,
               "report_type": "user_based",
               "config": {
                  "training_percentage": 0.9,
                  "evaluation_percentage": 0.1,
                  "margin_for_error": 0.5
               }
            }
         }
      ]
   }
}')
  result['hits']['hits'].first['_source']['evaluation']
  end

  def get_rsme_recomender_result(result=nil)
    result = JSON.parse('{
     "took": 1,
     "timed_out": false,
     "_shards": {
        "total": 5,
        "successful": 5,
        "failed": 0
     },
     "hits": {
        "total": 1,
        "max_score": 1,
        "hits": [
           {
              "_index": "yelp_recommend",
              "_type": "report",
              "_id": "AUyQdMHhPuxBJMH2xNqG",
              "_score": 1,
              "_source": {
                 "evaluation": {
                    "score": 1.1694837985749913,
                    "stdDeviation": 19.926948874278594,
                    "target": {
                       "test": 668,
                       "training": 6288
                    }
                 },
                 "@timestamp": "2015-04-06T20:38:33.184Z",
                 "evaluator_id": "yelp_recommend_result_RMS_10_90_LogLikelihoodSimilarityFactory_NearestNUserNeighborhoodFactory_10",
                 "report_type": "user_based",
                 "config": {
                    "training_percentage": 0.9,
                    "evaluation_percentage": 0.1,
                    "margin_for_error": 0.5
                 }
              }
           }
        ]
     }
  }')
    result['hits']['hits'].first['_source']['evaluation']
  end
end
