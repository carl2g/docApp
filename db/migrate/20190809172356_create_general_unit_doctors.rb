class CreateGeneralUnitDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :general_unit_doctors do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :general_unit, index: true
    end
  end
end
