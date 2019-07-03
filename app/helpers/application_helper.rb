module ApplicationHelper

  def resource_name
    :person
  end

  def resource
    @resource ||= Person.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:person]
  end

  def category_options
  	Category.all.map { |c|[c.title.capitalize, c.id]}
  end

  def list_category
    list_category = Category.all
    list_category = list_category.sort {|x, y | y.posts.count <=> x.posts.count }
    list_category = list_category.first(4)
  end

end
