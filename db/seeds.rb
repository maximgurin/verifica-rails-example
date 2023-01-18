foocorp = Organization.create!(name: "Foo Corporation", deny_countries: ["CA"])
foocorp_member = User.create!(name: "FooCorp Member", role: "user", country: "US", organization: foocorp)
User.create!(name: "FooCorp Other Member", role: "user", country: "IT", organization: foocorp)
User.create!(name: "FooCorp Admin", role: "organization_admin", country: "US", organization: foocorp)

foocorp_public_ds = DistributionSetting.create!(name: "FooCorp Public", mode: "public", owner: foocorp_member)
foocorp_internal_ds = DistributionSetting.create!(name: "FooCorp Internal", mode: "internal", owner: foocorp_member)
foocorp_private_ds = DistributionSetting.create!(name: "Private", mode: "private", owner: foocorp_member)

Video.create!(
  name: "FooCorp Public Video",
  draft: false,
  author: foocorp_member,
  distribution_setting: foocorp_public_ds
)
Video.create!(
  name: "FooCorp Internal Video",
  draft: false,
  author: foocorp_member,
  distribution_setting: foocorp_internal_ds
)
Video.create!(
  name: "FooCorp Private Video",
  draft: false,
  author: foocorp_member,
  distribution_setting: foocorp_private_ds
)
Video.create!(
  name: "FooCorp Draft Video",
  draft: true,
  author: foocorp_member,
  distribution_setting: foocorp_public_ds
)

alice = User.create!(name: "Alice", role: "user", country: "CA")
alice_allowlist_canada_ds = DistributionSetting.create!(name: "Allowlist Canada", owner: alice, mode: "public", allow_countries: ["CA"])
Video.create!(
  name: "Alice Allowlist Canada Video",
  draft: false,
  author: alice,
  distribution_setting: alice_allowlist_canada_ds
)

bob = User.create!(name: "Bob", role: "user", country: "CA")
bob_denylist_us_ds = DistributionSetting.create!(name: "Denylist US", owner: bob, mode: "public", deny_countries: ["US"])
Video.create!(
  name: "Bob Denylist US Video",
  draft: false,
  author: bob,
  distribution_setting: bob_denylist_us_ds
)

User.create!(name: "Moderator", role: "moderator", country: "FR")
User.create!(name: "Superuser", role: "root", country: "US")
