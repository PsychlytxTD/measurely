class Item < ApplicationRecord
  self.table_name = 'item'
  # self.primary_key = 'id'
  scope :clinician_id_equals, ->(clinician_id) { where(clinician_id: clinician_id) if clinician_id.present? }
  belongs_to :scale
  
end
