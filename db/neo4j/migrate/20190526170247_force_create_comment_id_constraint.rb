class ForceCreateCommentIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Comment, :id, force: true
  end

  def down
    drop_constraint :Comment, :id
  end
end
