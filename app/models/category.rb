class Category
  include Neo4j::ActiveNode
  property :title, type: String
  property :about, type: String
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :color, type: String, default: "_007bff"

  id_property :id, auto: :uuid
  has_many :in, :posts, type: :belong_to
  def list_group
  	group = [] 
  	self.posts.select {|x| x.belong_to && group << x.belong_to}
  	group.uniq
  end
  def posts_to_pretty
    number = self.posts.count
    if number < 2
      "#{number} post"
    elsif number > 1 && number < 999
      "#{number} posts"
    elsif number > 999
      "> #{number/1000}k posts"
    end 
  end
end
