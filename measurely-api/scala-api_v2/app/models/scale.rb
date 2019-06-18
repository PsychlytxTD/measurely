class Scale < ApplicationRecord
  self.table_name = 'scale'
  self.primary_key = 'scale_id'
  scope :clinician_id_equals, ->(clinician_id) { where(clinician_id: clinician_id) if clinician_id.present? }
  belongs_to :client

  after_initialize :set_names

  attr_accessor :first_name, :last_name

  def set_names
    self.first_name ||= client.try(:first_name)
    self.last_name ||= client.try(:last_name)
  end
end
