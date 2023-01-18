class Video < ApplicationRecord
  belongs_to :distribution_setting
  belongs_to :author, class_name: "User"

  before_save :update_read_acl

  attr_accessor :allowed_actions
  alias_method :resource_id, :id

  def resource_type = :video

  def update_read_acl
    acl = AUTHORIZER.resource_acl(self)
    self.read_allow_sids = acl.allowed_sids(:read)
    self.read_deny_sids = acl.denied_sids(:read)
  end

  scope :available_for, ->(user) do
    sids = user.subject_sids
    where("read_allow_sids && ARRAY[?]::varchar[]", sids).where.not("read_deny_sids && ARRAY[?]::varchar[]", sids)
  end
end
