class Category
  include Neo4j::ActiveNode
  property :title, type: String
  property :about, type: String
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :color, type: String

  id_property :id, auto: :uuid
  has_many :in, :posts, type: :belong_to

end
