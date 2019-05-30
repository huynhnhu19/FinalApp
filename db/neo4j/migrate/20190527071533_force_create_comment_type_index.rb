class ForceCreateCommentTypeIndex < Neo4j::Migrations::Base
  def up
    add_index :Comment, :type, force: true
  end

  def down
    drop_index :Comment, :type
  end
end
