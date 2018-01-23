class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :email
      t.text :name
      t.text :image
      t.text :password_digest

      t.timestamps
    end
  end
end
