class ForceCreateCategoryIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Category, :id, force: true
  end

  def down
    drop_constraint :Category, :id
  end
end
