class CreateModelNote < ActiveRecord::Migration[5.2]
  def change
    add_column :general_units, 	:note_model, :json, default: {}
    g_unit = GeneralUnit.find_by(name: "diabetes")
    g_unit.update(note_model: [
   {
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
]
)
  end
end
