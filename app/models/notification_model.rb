class NotificationModel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :remain_message, type: String
  belongs_to :listen
  embeds_many :wanted_items
end

# {
#   "wanted_itens":[
#     "pre_text":""
#     "url":""
#     "distinguer":{}
#     "indentifier":""
#     "recursive_path":[]
#     "wanted_value":""
#     ],
#     "remain_message":""
# }