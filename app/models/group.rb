class Group
	include Neo4j::ActiveNode
	property :group_name
	property :created_at, type: DateTime
  property :updated_at, type: DateTime
	id_property :id, auto: :uuid

	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :members, type: :joins, model_class: :Person
	has_many :in, :posts, origin: :belong_to

end
