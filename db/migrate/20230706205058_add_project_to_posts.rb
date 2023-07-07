class AddProjectToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_project, :boolean
  end
end
