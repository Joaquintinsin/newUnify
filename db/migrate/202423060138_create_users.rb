class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :lastname
      t.string :cellphone
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
