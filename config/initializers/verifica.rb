require "verifica"

Rails.configuration.after_initialize do
  AUTHORIZER = Verifica.authorizer do |config|
    config.register_resource :video, VideoAclProvider::POSSIBLE_ACTIONS, VideoAclProvider.new
  end
end
