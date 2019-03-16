class Message
	include Neo4j::ActiveNode
	property :content, type: String

	has_one :out, :sender, type: :send_by, model_class: :Person
	has_one :out, :receiver, type: :receive_by, model_class: :Person

end