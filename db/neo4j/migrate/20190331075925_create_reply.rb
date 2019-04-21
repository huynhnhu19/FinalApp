class CreateReply < Neo4j::Migrations::Base
  def up
    add_constraint :Reply, :uuid
  end

  def down
    drop_constraint :Reply, :uuid
  end
end
