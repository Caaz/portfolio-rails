class ChangeProjectToNonNullableOnPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :is_project
    add_column :posts, :project, :boolean, null: false, default: false
  end
end
