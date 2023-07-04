class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.string :password_digest, null: false
      t.string :img_url
      t.boolean :is_admin, null: false

      t.timestamps
    end
  end
end
