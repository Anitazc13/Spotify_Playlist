require "httparty"

class RecommendService
  include HTTParty
  base_uri "https://api.spotify.com/v1/recommendations/"

  def self.randomlist(token, gender)
    options = {
      headers: {
        Authorization: "Bearer #{token}"

      }
      query: {
        seed_genres: "#{gender}"
      }
    }
    response = get("/", options)
    raise HTTParty::ResponseError, response unless response.success?
    # list(@token).success? --> true if the parse_responsed is ok
    JSON.parse(response.body, symbolize_names: true) if response.body
    #to prove this methos use the hardcode
    #p PlaylistService.list("BQBblZTBx6xJSK9G0HdLSBzbldUd14Z737NCDqzouZ57FVOcvq_p28SlF1MPYy2ey7pOJvkwAg9Qh3r7cvc").class
  end
end

p RecommendService.randomlist("BQAgrwQ3ieSuGIFS1UxBG0RhzsuEa62ATm5xB03_p4WBDnAudwfwZ_s2c6GQezF5Y8G5mQC47QS0fMY_WuU","rock").class
# puts the time in ms
# GET the list
# PARSE to the string body
# User the method in the main.rb
