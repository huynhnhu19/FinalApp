class ForceCreatePersonPersonalIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Person, :personal_id, force: true
  end

  def down
    drop_constraint :Person, :personal_id
  end
end
