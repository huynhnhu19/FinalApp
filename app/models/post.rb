class Post
	include Neo4j::ActiveNode
	property :tittle, type: String
	property :content, type: String

	has_many :in, :comments, origin: :post
	has_one :out, :author, type: :author, model_class: :Person
	has_one :out, :belong_to, type: :belong_to, model_class: :Group
	has_many :in, :likes, type: :like, model_class: :Person
end