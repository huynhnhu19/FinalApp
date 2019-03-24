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


  has_many :in, :posts, origin: :author
	has_many :in, :comments, origin: :author
  has_many :in, :send_messages, origin: :sender
  has_many :in, :receive_messages, origin: :receiver
	has_many :in, :written_things, type: :wrote, model_class: [:Post, :Comment]

  has_many :both, :friends,type: :friend_with, model_class: :Person, unique: true

end

