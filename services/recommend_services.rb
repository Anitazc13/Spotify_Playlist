require "httparty"

module Services
  class RecommendService
    include HTTParty
    base_uri "https://api.spotify.com/v1/recommendations/"

    def self.songs_list(token, gender)
      options = {
        headers: {
          Authorization: "Bearer #{token}"

        },
        query: {
          seed_genres: gender.to_s
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
# HD
