class Listen < ApplicationRecord
  validates_presence_of :element_indentifier, :name, :site_id
  belongs_to :site
  has_one :notification_model
  has_one :model_task
end
