class ForceCreateGroupTypeIndex < Neo4j::Migrations::Base
  def up
    add_index :Group, :type, force: true
  end

  def down
    drop_index :Group, :type
  end
end
