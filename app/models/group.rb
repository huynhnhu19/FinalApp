class Group
	include Neo4j::ActiveNode

	id_property :id, auto: :uuid

	property :group_name
  property :about, type: String
  property :them, type: String
  property :text_color, type: String

  property :icon, type: String
  mount_uploader :icon, GroupBannerUploader
  property :banner, type: String
  mount_uploader :banner, GroupIconUploader

	property :created_at, type: DateTime
	property :updated_at, type: DateTime

	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :members, type: :joins, model_class: :Person
	has_many :in, :posts, origin: :belong_to

end
