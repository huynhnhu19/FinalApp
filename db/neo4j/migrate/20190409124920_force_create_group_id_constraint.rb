class ForceCreateGroupIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Group, :id, force: true
  end

  def down
    drop_constraint :Group, :id
  end
end
