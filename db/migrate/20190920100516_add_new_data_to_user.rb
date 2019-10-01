class AddNewDataToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, 	:birthdate, :string
    add_column :users, 	:civility, :string
  end
end
