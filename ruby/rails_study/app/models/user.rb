class User < ApplicationRecord
  include UserSearchable

  has_many :microposts
  validates :name, presence: true
end
__END__

User.__elasticsearch__.client.cluster.health
# => 
# {"cluster_name"=>"elasticsearch_brew",                         
#  "status"=>"yellow",                               
#  "timed_out"=>false,                               
#  "number_of_nodes"=>1,                             
#  "number_of_data_nodes"=>1,                        
#  "active_primary_shards"=>1,                       
#  "active_shards"=>1,                               
#  "relocating_shards"=>0,                           
#  "initializing_shards"=>0,                         
#  "unassigned_shards"=>1,                           
#  "delayed_unassigned_shards"=>0,                   
#  "number_of_pending_tasks"=>0,
#  "number_of_in_flight_fetch"=>0,
#  "task_max_waiting_in_queue_millis"=>0,
#  "active_shards_percent_as_number"=>50.0}

User.create_index!
# => {"acknowledged"=>true, "shards_acknowledged"=>true, "index"=>"es_user_development"}

User.__elasticsearch__.import
#    (0.0ms)  SELECT sqlite_version(*)
#   User Load (0.6ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1000]]                                                         
# => 0 

curl -XGET 'localhost:9200/es_user_development/_mapping/_doc?include_type_name=true&pretty'
# {
#   "es_user_development" : {
#     "mappings" : {
#       "_doc" : {
#         "dynamic" : "false",
#         "properties" : {
#           "id" : {
#             "type" : "integer"
#           },
#           "name" : {
#             "type" : "text",
#             "analyzer" : "kuromoji"
#           }
#         }
#       }
#     }
#   }
# }

# 全件検索
curl -XGET "http://localhost:9200/es_user_development/_search?pretty"
# {
#   "took" : 1,
#   "timed_out" : false,
#   "_shards" : {
#     "total" : 1,
#     "successful" : 1,
#     "skipped" : 0,
#     "failed" : 0
#   },
#   "hits" : {
#     "total" : {
#       "value" : 3,
#       "relation" : "eq"
#     },
#     "max_score" : 1.0,
#     "hits" : [
#       {
#         "_index" : "es_user_development",
#         "_type" : "_doc",
#         "_id" : "1",
#         "_score" : 1.0,
#         "_source" : {
#           "id" : 1,
#           "name" : "yoshinori kodama"
#         }
#       },
#       {
#         "_index" : "es_user_development",
#         "_type" : "_doc",
#         "_id" : "2",
#         "_score" : 1.0,
#         "_source" : {
#           "id" : 2,
#           "name" : "megumi hosoda"
#         }
#       },
#       {
#         "_index" : "es_user_development",
#         "_type" : "_doc",
#         "_id" : "3",
#         "_score" : 1.0,
#         "_source" : {
#           "id" : 3,
#           "name" : "hoge taro"
#         }
#       }
#     ]
#   }
# }

User.search("kodama").results.first
# => 
# #<Elasticsearch::Model::Response::Result:0x00007ff2dbddae48
#  @result=
#   {"_index"=>"es_user_development",
#    "_type"=>"_doc",
#    "_id"=>"1",
#    "_score"=>0.9808291,
#    "_source"=>{"id"=>1, "name"=>"yoshinori kodama"}}>

User.search(query: {term: {name: "児玉"} }).results.first
# => 
# #<Elasticsearch::Model::Response::Result:0x00007ff2dd046a28
#  @result=                                              
#   {"_index"=>"es_user_development",                    
#    "_type"=>"_doc",                                    
#    "_id"=>"4",                                 
#    "_score"=>1.2039728,                        
#    "_source"=>{"id"=>4, "name"=>"児玉 義憲"}}>

User.es_search("児玉").results.first
# => 
# #<Elasticsearch::Model::Response::Result:0x00007ff2d79ac230
#  @result=                                          
#   {"_index"=>"es_user_development",                
#    "_type"=>"_doc",                                
#    "_id"=>"4",                                     
#    "_score"=>1.2039728,                            
#    "_source"=>{"id"=>4, "name"=>"児玉 義憲"}}>
