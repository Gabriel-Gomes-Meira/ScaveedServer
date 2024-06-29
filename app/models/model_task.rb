class ModelTask < ApplicationRecord
  has_one :listen
  has_many :cron
end