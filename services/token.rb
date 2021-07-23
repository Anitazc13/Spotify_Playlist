require "httparty"
require "json"
require "base64"

module Services
  class Token
    include HTTParty

    base_uri "https://accounts.spotify.com"
    def self.auth_string_calc
      # client_id = "50283f807bc74fecbc2e61563d34e051"
      # client_secret = "37afc91e05f146dba6b3dcca57b8b900"
      # auth_string = "Basic #{Base64.encode64(client_id)}:#{Base64.encode64(client_secret)}"
      "Basic NTAyODNmODA3YmM3NGZlY2JjMmU2MTU2M2QzNGUwNTE6MzdhZmM5MWUwNWYxNDZkYmE2YjNkY2NhNTdiOGI5MDA="
    end

    def self.request_authorization
      auth_string = auth_string_calc
      options = {
        headers: {
          Authorization: auth_string,
          "Content-type": "application/x-www-form-urlencoded"
        },
        body: { grant_type: "client_credentials" }
      }
      response = post("/api/token", options)
      JSON.parse(response.body, symbolize_names:true)
    end
  end
end
