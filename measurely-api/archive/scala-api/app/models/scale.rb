class Scale < ApplicationRecord
  self.table_name = "scale"
  belongs_to :client
end
