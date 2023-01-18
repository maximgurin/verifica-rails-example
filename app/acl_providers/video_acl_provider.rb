# frozen_string_literal: true

class VideoAclProvider
  include Verifica::Sid

  POSSIBLE_ACTIONS = [:read, :write, :delete].freeze

  def call(video, **)
    Verifica::Acl.build do |acl|
      acl.allow root_sid, POSSIBLE_ACTIONS
      acl.allow user_sid(video.author_id), POSSIBLE_ACTIONS
      acl.allow role_sid("moderator"), [:read, :delete]

      next if video.draft?

      ds = video.distribution_setting
      author_org = video.author.organization
      allowed_countries = author_org&.allow_countries || ds.allow_countries
      denied_countries = author_org&.deny_countries || ds.deny_countries

      unless author_org.nil?
        add_org_rules(acl, author_org, ds)
      end

      case ds.mode
      when "public" # video is available for any authenticated user taking country restrictions into account
        add_public_rules(acl, allowed_countries, denied_countries)
      when "internal" # video is available for members of author's organization
        # do nothing, internal mode is already handled in #add_org_rules
      when "private" # video is available for its author only
        # do nothing, private mode is already handled above, video available for its author
      else
        throw RuntimeError("Unsupported video distribution mode: #{ds.mode}")
      end
    end
  end

  def add_org_rules(acl, author_org, distribution_setting)
    org_id = author_org.id
    acl.allow role_sid("organization_admin:#{org_id}"), POSSIBLE_ACTIONS

    if distribution_setting.mode == "internal"
      acl.allow organization_sid(org_id), [:read]
    end
  end

  def add_public_rules(acl, allowed_countries, denied_countries)
    # if allowed_countries are empty distribution is in "denylist" mode
    # otherwise distribution is in "allowlist" mode
    if allowed_countries.empty?
      acl.allow authenticated_sid, [:read]
      denied_countries.each do |country|
        acl.deny "country:#{country}", [:read]
      end
    else
      allowed_countries.each do |country|
        acl.allow "country:#{country}", [:read]
      end
    end
  end
end
