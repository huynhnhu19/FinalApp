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

	has_one :out, :author, type: :create_by, model_class: :Person
	has_many :in, :members, type: :joins, model_class: :Person
	has_many :in, :posts, origin: :belong_to

	def check_color
		self.text_color.present? ? self.text_color : '_0079d3'
	end
	
	def check_them
		self.them.present? ? self.them : '_0079d3'
	end

	def check_view mode_view, params
		if mode_view == params 
			self.text_color.present? ? self.text_color : '_0079d3'
		else
			"gray"
		end
	end
			
end
