require "httparty"

class PlaylistService
  include HTTParty
  base_uri "https://api.spotify.com/v1/recommendations/available-genre-seeds/"
  @token = "BQBblZTBx6xJSK9G0HdLSBzbldUd14Z737NCDqzouZ57FVOcvq_p28SlF1MPYy2ey7pOJvkwAg9Qh3r7cvc"

  #this method gives you a list of genres that exists in spotify
  def self.list(token)
    options = {
      headers: {
        Authorization: "Bearer #{token}"
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

# puts the time in ms
# GET the list
# PARSE to the string body
# User the method in the main.rb

