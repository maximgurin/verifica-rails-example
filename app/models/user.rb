class User < ApplicationRecord
  include Verifica::Sid

  belongs_to :organization, optional: true
  has_many :distribution_settings
  has_many :videos

  alias_method :subject_id, :id

  def subject_type = :user

  def subject_sids(**)
    case role
    when "root"
      [root_sid]
    when "moderator"
      [user_sid(id), role_sid("moderator")]
    when "user"
      sids = [authenticated_sid, user_sid(id), "country:#{country}"]
      organization_id.try { |org_id| sids.push(organization_sid(org_id)) }
      sids
    when "organization_admin"
      sids = [authenticated_sid, user_sid(id), "country:#{country}"]
      sids.push(organization_sid(organization_id))
      sids.push(role_sid("organization_admin:#{organization_id}"))
    else
      throw RuntimeError("Unsupported user role: #{role}")
    end
  end

  def country_name = ISO3166::Country.new(country).common_name

  def country_flag = ISO3166::Country.new(country).emoji_flag
end
