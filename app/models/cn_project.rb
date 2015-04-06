class CnProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :congressional_notification
end
