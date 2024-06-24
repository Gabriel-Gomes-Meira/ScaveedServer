class Cron < ApplicationRecord
    validates_presence_of :name, :interval
    has_one :model_task
end
