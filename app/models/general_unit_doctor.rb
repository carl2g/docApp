class GeneralUnitDoctor < ApplicationRecord
  belongs_to  :doctor
  belongs_to  :general_unit
end
