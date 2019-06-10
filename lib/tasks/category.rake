namespace :category do
  desc "TODO"
  task create_category: :environment do
		categories = [{title: "health", color: "007bff"}, 
			{title: "dentist", color: "104939"}, 
			{title: "cancer", color: "6610f2"}, 
			{title: "nutrition", color: "40dbed"},
			{title: "physiotherapists", color: "e83e8c"}]
	categories.each do |c|
		Category.create!(c)
	end
  end

end
