class CreateComments < ActiveRecord::Migration[7.0]
  def up
    create_table :comments do |t|
      t.string :body
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end

    if (defined? GoalComment) && (defined? Comment)
      GoalComment.find_each do |comment|
        Comment.create!(body: comment.body, author: comment.author, 
                        commentable_type: :Goal, commentable_id: comment.id,
                        created_at: comment.created_at, updated_at: comment.updated_at
        )
      end
    end

    if (defined? UserComment) && (defined? Comment)
      UserComment.find_each do |comment|
        Comment.create!(body: comment.body, author: comment.author, 
                        commentable_type: :User, commentable_id: comment.id,
                        created_at: comment.created_at, updated_at: comment.updated_at
        )
      end
    end

    drop_table :goal_comments 
    drop_table :user_comments 
  end

  def down
    create_table :goal_comments do |t|
      t.string :body, null: false
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end

    create_table :user_comments do |t|
      t.string :body, null: false
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    if (defined? Comment) && (defined? GoalComment) && (defined? UserComment)
      Comment.find_each do |comment|
        comment.commentable_type == "Goal" ?
          GoalComment.create!(body: comment.body, author: comment.author, 
                              goal_id: comment.commentable_id, 
                              created_at: comment.created_at, updated_at: comment.updated_at
          ) :
          UserComment.create!(body: comment.body, author: comment.author, 
                              recipient_id: comment.commentable_id, 
                              created_at: comment.created_at, updated_at: comment.updated_at
          )
      end
    end

    drop_table :comments
  end
end