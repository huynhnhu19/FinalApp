class Reply 
  include Neo4j::ActiveNode
  
  property :content, type: String


  has_one :out, :comment, type: :reply_on
  has_one :out, :author, type: :author, model_class: :Person

end
