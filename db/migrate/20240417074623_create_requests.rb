class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :patient_id
      t.bigint :hospital_treatment_id
      t.integer "status", default: 0

      t.index :hospital_treatment_id, name: "index_requests_on_hospital_treatment_id"
      t.timestamps
    end
  end
end
