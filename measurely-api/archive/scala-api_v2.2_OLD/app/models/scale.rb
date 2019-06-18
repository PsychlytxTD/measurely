class Scale < ApplicationRecord
  self.table_name = 'scale'
  self.primary_key = 'client_id'
  scope :clinician_id_equals, ->(clinician_id) { where(clinician_id: clinician_id) if clinician_id.present? }
  belongs_to :client

  def first_name
    client.first_name
  end

  def last_name
    client.last_name
  end
end
