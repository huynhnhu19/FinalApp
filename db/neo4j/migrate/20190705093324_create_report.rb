class CreateReport < Neo4j::Migrations::Base
  def up
    add_constraint :Report, :uuid
  end

  def down
    drop_constraint :Report, :uuid
  end
end
