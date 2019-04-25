class Post
	include Neo4j::ActiveNode

	# property :posts_id, auto: :uuid
	property :title, type: String
	property :content, type: String
	property :image, type: String
	mount_uploader :image, ImageUploader
	property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :upvotes, type: Integer,  default: 0
  property :downvotes, type: Integer,  default: 0

	id_property :id, auto: :uuid

	has_many :in, :comments, origin: :post
	has_one :out, :author, type: :author, model_class: :Person
	has_one :out, :belong_to, type: :belong_to, model_class: :Group
  has_many :in, :upvote, type: :up_vote, model_class: :Person
	has_many :in, :downvote, type: :down_vote, model_class: :Person

  def votes
    self.upvotes - self.downvotes
  end

end