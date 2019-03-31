class Comment
	include Neo4j::ActiveNode
	property :content, type: String
	
	has_one :out, :post, type: :comment_on
	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :replies, origin: :comment
end