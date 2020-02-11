# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

puts "===================== Building ADMIN ====================="
puts "===================== Building Modules ====================="
GeneralUnit.create!({name: 'diabetes', 	color: 'blue', 	icon: 'to be defined'})
GeneralUnit.create!({name: 'asthma', 	color: 'red', 	icon: 'to be defined'})
GeneralUnit.create!({name: 'arthritis', color: 'green', 	icon: 'to be defined'})

diabet = GeneralUnit.find_by(name: "diabetes")
diabet.update(filter: {
    only: [
        :Glycemie,
        :Glucide,
        :InsulineAvRepas,
        :InsulineApRepas,
        :InsulineAJeun,
        :date,
        :heure
    ]
})

    Unit.where(general_unit: diabet.id).each do |u|
        u.update(filter: u.general_unit.filter)
    end

puts "===================== Building Patients ====================="
pa = Patient.createPatient({first_name: 'swager_patient', last_name: 'swager_patient', email: 'swager_patient@gmail.com', password: 'swager75', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: ''})
p1 = Patient.createPatient({first_name: 'patient1', last_name: 'patient1', email: 'patient1@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: ''})
p2 = Patient.createPatient({first_name: 'patient2', last_name: 'patient2', email: 'patient2@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Miss', phone_number: '00918989', picture: ''})
p3 = Patient.createPatient({first_name: 'patient3', last_name: 'patient3', email: 'patient3@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Other', phone_number: '00918989', picture: ''})
p4 = Patient.createPatient({first_name: 'patient4', last_name: 'patient4', email: 'patient4@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: ''})

# use this patient to test routes
pa.user.update!(login_token: 'pIopVfk23T1VjLfUFsJJ6Ne0ansJi9BhPOhvsMF36co')
pa.addUnit(GeneralUnit.find_by(name: "diabetes").id)

p1.addUnit(GeneralUnit.find_by(name: "diabetes").id)
p1.addUnit(GeneralUnit.find_by(name: "asthma").id)

p2.addUnit(GeneralUnit.find_by(name: "diabetes").id)

p3.addUnit(GeneralUnit.find_by(name: "asthma").id)
p3.addUnit(GeneralUnit.find_by(name: "arthritis").id)

p4.addUnit(GeneralUnit.find_by(name: "arthritis").id)

puts "===================== Building Doctors ====================="
# use this doctor to test routes
doc = Doctor.createDoctor({first_name: 'doctor', last_name: 'doctor', email: 'doctor@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: '', default_units: [1, 2]})
doc.user.update!(login_token: 'TwM4Wb6IRHeyT4r8BtUoYZOZxGNTo8dcWEucAomFGDo')

doc1 = Doctor.createDoctor({first_name: 'doctor_1', last_name: 'doctor_1', email: 'doctor_1@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: '', default_units: [1]})
doc2 = Doctor.createDoctor({first_name: 'doctor_2', last_name: 'doctor_2', email: 'doctor_2@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: '', default_units: [1, 2]})
doc3 = Doctor.createDoctor({first_name: 'doctor_3', last_name: 'doctor_3', email: 'doctor_3@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: '', default_units: [3]})
pa.units.find_by(general_unit_id: 1).addDoctor(doc.id)
pa.units.find_by(general_unit_id: 1).addDoctor(doc3.id)
pa.units.find_by(general_unit_id: 1).addDoctor(doc2.id)
pa.units.find_by(general_unit_id: 1).addDoctor(doc1.id)
p1.units.find_by(general_unit_id: 1).addDoctor(doc.id)
p1.units.find_by(general_unit_id: 2).addDoctor(doc.id)
p2.units.find_by(general_unit_id: 1).addDoctor(doc.id)
p3.units.find_by(general_unit_id: 2).addDoctor(doc.id)

puts "===================== Creating notes ====================="
patient_unit = pa.units.find_by(id: 1)
patient_unit.addNote({Glycemie: 22,
            Glucide: 12,
            InsulineAvRepas: 11,
            InsulineApRepas: 34,
            InsulineAJeun: 23,
            date: Date.new,
            heure: Time.now
    })
