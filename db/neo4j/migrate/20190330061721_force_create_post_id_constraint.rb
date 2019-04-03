class ForceCreatePostIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Post, :id, force: true
  end

  def down
    drop_constraint :Post, :id
  end
end
