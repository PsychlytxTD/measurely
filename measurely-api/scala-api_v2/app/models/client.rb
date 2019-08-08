class Client < ApplicationRecord
  self.table_name = 'client'
  # self.primary_key = 'id'
  has_many :scales, dependent: :destroy
  
  scope :clinician_id_equals, -> (clinician_id) { where(clinician_id: clinician_id) if clinician_id.present? }
end