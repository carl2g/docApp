# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

puts "===================== Building Modules ====================="
DModule.create({name: 'diabetes', 	color: 'blue', 	icon: 'to be defined'})
DModule.create({name: 'asthma', 	color: 'red', 	icon: 'to be defined'})
DModule.create({name: 'arthritis', 	color: 'green', 	icon: 'to be defined'})

puts "===================== Building Patients ====================="
Patient.createPatient({first_name: 'patient', last_name: 'patient', email: 'patient@gmail.com', password: '12345678'})

puts "===================== Building Doctors ====================="
Doctor.createDoctor({first_name: 'doctor', last_name: 'doctor', email: 'doctor@gmail.com', password: '12345678'})
