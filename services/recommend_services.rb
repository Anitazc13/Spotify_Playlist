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
pp RecommendService.randomlist("BQAgrwQ3ieSuGIFS1UxBG0RhzsuEa62ATm5xB03_p4WBDnAudwfwZ_s2c6GQezF5Y8G5mQC47QS0fMY_WuU",
                               "rock")
# puts the time in ms
# User the method in the main.rb
