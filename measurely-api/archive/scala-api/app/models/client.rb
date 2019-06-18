class Client < ApplicationRecord
  self.table_name = "client"
  has_many :scale
end
