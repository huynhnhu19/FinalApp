class ForceCreateMessageUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Message, :uuid, force: true
  end

  def down
    drop_constraint :Message, :uuid
  end
end
