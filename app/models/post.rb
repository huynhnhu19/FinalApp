class Post
	include Neo4j::ActiveNode

	# property :posts_id, auto: :uuid
	property :title, type: String
	property :content, type: String
	property :image, type: String
	mount_uploader :image, ImageUploader

	id_property :id, auto: :uuid

	has_many :in, :comments, origin: :post
	has_one :out, :author, type: :author, model_class: :Person
	has_one :out, :belong_to, type: :belong_to, model_class: :Group
	has_many :in, :likes, type: :like, model_class: :Person
end