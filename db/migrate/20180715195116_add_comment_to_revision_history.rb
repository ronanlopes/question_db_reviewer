class AddCommentToRevisionHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :revision_histories, :comment, :string
  end
end
