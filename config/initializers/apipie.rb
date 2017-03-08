Apipie.configure do |config|
  config.app_name                = "PlatformDev"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  config.app_info                = "Platform devs anagrams api documentation - V1.0"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
