class AddHookToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :hook, :string
  end
end
