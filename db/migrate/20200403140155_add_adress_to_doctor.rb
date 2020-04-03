class AddAdressToDoctor < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, 	:address, :string
  end
end
