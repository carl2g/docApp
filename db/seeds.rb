# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

puts "===================== Building Modules ====================="
GeneralUnit.create!({name: 'diabetes', 	color: 'blue', 	icon: 'to be defined'})
GeneralUnit.create!({name: 'asthma', 	color: 'red', 	icon: 'to be defined'})
GeneralUnit.create!({name: 'arthritis', color: 'green', 	icon: 'to be defined'})

puts "===================== Building Patients ====================="
Patient.createPatient({first_name: 'patient', last_name: 'patient', email: 'patient@gmail.com', password: '12345678'})
pa = Patient.createPatient({first_name: 'swager_patient', last_name: 'swager_patient', email: 'swager_patient@gmail.com', password: 'swager75'})
pa.user.update!(login_token: 'pIopVfk23T1VjLfUFsJJ6Ne0ansJi9BhPOhvsMF36co')
pa.addUnit(GeneralUnit.find_by(name: "diabetes"))

puts "===================== Building Doctors ====================="
doc = Doctor.createDoctor({first_name: 'doctor', last_name: 'doctor', email: 'doctor@gmail.com', password: '12345678'})
doc.user.update!(login_token: 'TwM4Wb6IRHeyT4r8BtUoYZOZxGNTo8dcWEucAomFGDo')
