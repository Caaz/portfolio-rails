class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :name
      t.integer :hits

      t.timestamps
    end
  end
end
