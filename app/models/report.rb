class Report
  include Neo4j::ActiveNode
  property :content, type: String
  property :type, type: String

  has_one :out, :reporter, type: :reporter, model_class: :Person
  has_one :out, :post_reports, type: :post_report, model_class: :Post

end
