class Group
	include Neo4j::ActiveNode
	property :group_name, type: String
	property :mode, type: Boolean

	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :members, type: :joins, model_class: :Person
	has_many :in, :posts, origin: :belong_to
	
end
