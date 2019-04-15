class Comment
	include Neo4j::ActiveNode
	property :content, type: String
	property :created_at, type: DateTime
  	property :updated_at, type: DateTime
	
	has_one :out, :post, type: :comment_on
	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :replies, origin: :comment
end