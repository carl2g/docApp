class AddAdminAccount < ActiveRecord::Migration[5.2]
  def up
    admin = User.generate_user({first_name: 'admin', last_name: 'admin', email: 'chronosymple_2021@labeip.epitech.eu', password: 'carlota', birthdate: '01/01/2020', civility: 'Mr', phone_number: '66666666', picture: ''})
    admin.add_role(:admin)
  end
end
