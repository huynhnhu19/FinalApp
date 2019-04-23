class Reply 
  include Neo4j::ActiveNode
  
  	property :content, type: String
  	property :created_at, type: DateTime
  	property :updated_at, type: DateTime
  	property :created_at, type: DateTime
	property :updated_at, type: DateTime

	has_one :out, :comment, type: :reply_on
	has_one :out, :author, type: :author, model_class: :Person

end
