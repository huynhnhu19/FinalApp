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
  has_many :in, :upvote, type: :upvoted_by, model_class: :Person
	has_many :in, :downvote, type: :downvoted_by, model_class: :Person

  def votes
    self.upvotes - self.downvotes
  end

	def controversial
		self.upvotes - self.downvotes
	end

	def to_pretty
    	a = (Time.now-self.created_at).to_i
	    case a
	      when 0 then 'just now'
	      when 1 then 'a second ago'
	      when 2..59 then a.to_s+' seconds ago'
	      when 60..119 then 'a minute ago' #120 = 2 minutes
	      when 120..3540 then (a/60).to_i.to_s+' minutes ago'
	      when 3541..7100 then 'an hour ago' # 3600 = 1 hour
	      when 7101..82800 then ((a+99)/3600).to_i.to_s+' hours ago'
	      when 82801..172000 then 'a day ago' # 86400 = 1 day
	      when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+' days ago'
	      when 518400..1036800 then 'a week ago'
	      else ((a+180000)/(60*60*24*7)).to_i.to_s+' weeks ago'
	    end
	end

  def display_comments
    if self.comments.count < 1
      "0"
    elsif self.comments.count == 1
      "1 Comment"
    else
      "#{self.comments.count} Comments"
    end
  end

end