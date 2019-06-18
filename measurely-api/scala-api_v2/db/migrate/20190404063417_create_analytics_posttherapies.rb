class CreateAnalyticsPosttherapies < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :analytics_posttherapies, id: :uuid do |t|
      t.uuid :clinician_id
      t.uuid :client_id
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.string :birth_date
      t.string :postcode
      t.string :marital_status
      t.string :sexuality
      t.string :ethnicity
      t.string :indigenous
      t.string :children
      t.string :workforce_status
      t.string :education_status
      t.timestamps
    end

    create_table :client, id: :uuid do |t|
      t.uuid :clinician_id
      t.uuid :client_id
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.string :birth_date
      t.string :postcode
      t.string :marital_status
      t.string :sexuality
      t.string :ethnicity
      t.string :indigenous
      t.string :children
      t.string :workforce_status
      t.string :education
      t.timestamps
    end

    create_table :clinician, id: :uuid do |t|
      t.uuid :clinician_id
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :posttherapy_analytics, id: :uuid do |t|
      t.uuid :clinician_id
      t.uuid :client_id
      t.string :principal_diagnosis
      t.string :secondary_diagnosis
      t.string :attendance_schedule
      t.integer :non_attendances
      t.integer :attendances
      t.integer :out_of_pocket
      t.string :premature_dropout
      t.string :therapy
      t.string :funding
      t.string :referrer
      t.timestamps
    end
    
    create_table :scale, id: :uuid do |t|
      t.uuid :clinician_id
      t.uuid :client_id
      t.string :measure
      t.string :subscale
      t.string :date
      t.integer :score
      t.integer :pts
      t.integer :se
      t.integer :ci
      t.integer :ci_upper
      t.integer :ci_lower
      t.integer :mean
      t.string :mean_reference
      t.integer :sd
      t.string :sd_reference
      t.integer :reliability
      t.string :reliability_reference
      t.integer :confidence
      t.string :method
      t.string :population
      t.string :cutoff_label_1
      t.string :cutoff_label_2
      t.string :cutoff_label_3
      t.string :cutoff_label_4
      t.string :cutoff_label_5
      t.integer :cutoff_value_1
      t.integer :cutoff_value_2
      t.integer :cutoff_value_3
      t.integer :cutoff_value_4
      t.integer :cutoff_value_5
      t.string :cutoff_reference_1
      t.string :cutoff_reference_2
      t.string :cutoff_reference_3
      t.string :cutoff_reference_4
      t.string :cutoff_reference_5
      t.timestamps
    end
  end
end
