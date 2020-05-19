class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.password_digest :password
      t.text :discription

      t.timestamps null: false
    end
  end
end