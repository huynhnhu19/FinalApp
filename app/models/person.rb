class Person
	include Neo4j::ActiveNode
  #
  # Neo4j.rb needs to have property definitions before any validations. So, the property block needs to come before
  # loading your devise modules.
  #
  # If you add another devise module (such as :lockable, :confirmable, or :token_authenticatable), be sure to
  # uncomment the property definitions for those modules. Otherwise, the unused property definitions can be deleted.
  #

  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  ## Database authenticatable
  property :email, type: String, default: ''
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  property :encrypted_password

  ## If you include devise modules, uncomment the properties below.

  ## Recoverable
  property :reset_password_token
  property :reset_password_sent_at, type: DateTime

  ## Rememberable
  property :remember_created_at, type: DateTime

  ## Trackable
  property :sign_in_count, type: Integer, default: 0
  validates :sign_in_count, presence: true
  property :current_sign_in_at, type: DateTime
  property :last_sign_in_at, type: DateTime
  property :current_sign_in_ip, type:  String
  property :last_sign_in_ip, type: String

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  id_property :personal_id, auto: :uuid
  property :first_name, type: String
  property :last_name, type: String
  property :display_name, type: String
  property :about, type: String
  property :person_type, type: String


  property :avatar, type: String
  mount_uploader :avatar, AvatarUploader
  property :banner, type: String
  mount_uploader :banner, UserBannerUploader

  has_many :in, :posts, origin: :author
  has_many :in, :comments, origin: :author
  has_many :in, :replies, origin: :author
  has_many :in, :send_messages, origin: :sender
  has_many :in, :receive_messages, origin: :receiver
	has_many :in, :written_things, type: :wrote, model_class: [:Post, :Comment]
  has_many :in, :groups, origin: :author
  has_many :in, :join_groups, type: :joins, model_class: :Group
  has_many :in, :posts_saved, type: :save, model_class: :Post
  has_many :in, :posts_hidden, type: :hide, model_class: :Post
  has_many :in, :upvote, type: :upvoted, model_class: :Post
  has_many :in, :downvote, type: :downvoted, model_class: :Post
  has_many :in, :upvote_comment, type: :comment_upvoted, model_class: :Comment
  has_many :in, :downvote_comment, type: :comment_downvoted, model_class: :Comment

  has_many :in, :followings, type: :following, model_class: :Person
  has_many :in, :followers, type: :followed_by, model_class: :Person
  has_many :in, :post_reportions, type: :report_post, model_class: :Post
  has_many :in, :reportions, type: :report, model_class: :Report


  after_create :add_default_images

  def add_default_images
    File.open('public/icon-default.jpg') do |f|
      self.avatar = f
    end
    File.open('public/banner-default.jpg') do |f|
      self.banner = f
    end
    self.save!
  end
  def full_name
    "#{first_name} #{last_name}"
  end
end

