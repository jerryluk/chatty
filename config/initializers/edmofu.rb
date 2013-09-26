module Edmodo
  module API
    module Config
      self.endpoints = {
        :production => "https://appsapi.edmodo.com/#{version}",
        :sandbox => "https://appsapi.edmodobox.com/#{version}",
        :devbox => "https://appsapi.jerry-west.edmotrunk.com/#{version}"
      }
    end
  end
end

Edmofu.configs[:api_key] = "d931875283d5fffc35c99fe2c5975b3cd100ba27"
Edmofu.configs[:app_mode] = "devbox"
