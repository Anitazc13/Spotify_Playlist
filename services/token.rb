require "httparty"
require "json"

module Services
  class Token
    include HTTParty

    base_uri "https://accounts.spotify.com"

    def self.request_authorization
      client_id = "50283f807bc74fecbc2e61563d34e051"
      client_secret = "32ca05440d3b447999a8135f984b8b68"
      options = {
        headers: {
          Authorization: "Basic #{client_id}:#{client_secret}"
        },
        body: {"grant_type": "client_credentials" }
      }
      response = post("/api/token", options)
      p response.body

    end
  end
end
