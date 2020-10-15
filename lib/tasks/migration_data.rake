namespace :migration do
  task apply_updates: :environment do
  	Rake::Task["migration:update_general_units"].invoke
  end

  task update_general_units: :environment do
  	diabet = GeneralUnit.find_by(name: "diabetes")
  	diabet.update(filter: {
		    only: [
            :bloodGlucose,
            :insulineFood,
            :insulineCorr,
            :description,
            :wichLunch,
            :date,
            :heure
		    ]
		})

    diabet.units.each do |u|
      u.update({filter: diabet.filter})
      u.doctor_units.each do |du|
        du.doctor_unit_notes.each do |dun|
          dun.update({filter: u.filter})
        end
      end
    end

  	diabet.update(note_model: [{
            "name": "Glucose : ",
            "defaultText": "",
            "tag": "bloodGlucose",
            "icon": {
               "icon_name": "",
               "icon_color": "yellow"
            },
            "field_type": "text",
            "placeholder": "mmol/L",
            "keyboardType": "numeric"
         },
         {
            "name": "Insuline (Nourr)",
            "defaultText": "",
            "tag": "insulineFood",
            "icon": {
               "icon_name": "",
               "icon_color": "green"
            },
            "field_type": "text",
            "placeholder": "Unité",
            "keyboardType": "numeric"
         },
         {
            "name": "insuline (Corr)",
            "defaultText": "",
            "tag": "insulineCorr",
            "icon": {
               "icon_name": "",
               "icon_color": "red"
            },
            "field_type": "text",
            "placeholder": "Unité",
            "keyboardType": "numeric"
         },
         {
            "name": "Description : ",
            "defaultText": "",
            "tag": "description",
            "icon": {
               "icon_name": "",
               "icon_color": "blue"
            },
            "field_type": "text",
            "placeholder": "ex: j'ai mangé...",
            "keyboardType": "default"
         },
         {
            "name": "Quel période?",
            "defaultText": "Petit déjeuner",
            "tag": "wichLunch",
            "icon": {
               "icon_name": "",
               "icon_color": "blue"
            },
            "field_type": "select",
            "placeholder": "ex: j'ai mangé...",
            "select_values": [
               "Petit déjeuner",
               "Repas",
               "Goûter",
               "Grignotage",
               "Dîner"
            ]
         }
      ])
  end

  task generate_new_general_unit: :environment do
    GeneralUnit.create({
      name: "hypertension",
      icon: nil,
      color: "red",
      filter: {
         "only":[
            "tension_systolique",
            "tension_diastolique",
            "description",
            "date",
            "heure"
         ]
      },
      note_model: [
   {
      "name":"Tension Systolique : ",
      "defaultText":"",
      "tag":"tension_systolique",
      "icon":{
         "icon_name":"",
         "icon_color":"yellow"
      },
      "field_type":"text",
      "placeholder":"mmHg",
      "keyboardType":"numeric"
   },
   {
      "name":"tension diastolique",
      "defaultText":"",
      "tag":"tension_diastolique",
      "icon":{
         "icon_name":"",
         "icon_color":"green"
      },
      "field_type":"text",
      "placeholder":"mmHg",
      "keyboardType":"numeric"
   },
   {
      "name":"Description : ",
      "defaultText":"",
      "tag":"description",
      "icon":{
         "icon_name":"",
         "icon_color":"blue"
      },
      "field_type":"text",
      "placeholder":"ex: je me sens stressé",
      "keyboardType":"default"
   }
]
    })
  end

end