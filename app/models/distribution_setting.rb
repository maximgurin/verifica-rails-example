class DistributionSetting < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :videos
end
