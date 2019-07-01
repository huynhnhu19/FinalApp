class ForceCreateAdminUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Admin, :uuid, force: true
  end

  def down
    drop_constraint :Admin, :uuid
  end
end
