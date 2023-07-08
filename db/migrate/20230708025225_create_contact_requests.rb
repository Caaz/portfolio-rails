class CreateContactRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_requests do |t|
      t.string :name
      t.text :message
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
