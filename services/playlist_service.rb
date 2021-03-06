require "httparty"

module Services
  class PlaylistService
    include HTTParty
    base_uri "https://api.spotify.com/v1/recommendations/available-genre-seeds/"

    # this method gives you a list of genres that exists in spotify
    def self.genres_list(token)
      options = {
        headers: {
          Authorization: "Bearer #{token}"
        }
      }
      response = get("/", options)
      raise HTTParty::ResponseError, response unless response.success?

      # list(@token).success? --> true if the parse_responsed is ok
      JSON.parse(response.body, symbolize_names: true) if response.body
      # to prove this methos use the hardcode
    end
  end
end
