class ModelTask < ApplicationRecord
  has_one :listen
  has_one :cron
end