class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true, index: true
    end
  end
end
