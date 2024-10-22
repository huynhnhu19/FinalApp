class Comment
	include Neo4j::ActiveNode
	property :content, type: String
	property :created_at, type: DateTime
	property :updated_at, type: DateTime
  	property :upvotes, type: Integer,  default: 0
  	property :downvotes, type: Integer,  default: 0

  	id_property :id, auto: :uuid

	has_one :out, :post, type: :comment_on
	has_one :out, :author, type: :author, model_class: :Person
	has_many :in, :replies, type: :reply_on, model_class: :Comment, dependent: :destroy
  	has_many :in, :upvote, type: :upvoted_by, model_class: :Person
  	has_many :in, :downvote, type: :downvoted_by, model_class: :Person

	enum type: [:comment, :reply], _default: :comment

  	def votes
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

  def add_upvote person
    person.upvote_comment << self
    self.upvote << person
    self.update_column :upvotes, 1
  end
end