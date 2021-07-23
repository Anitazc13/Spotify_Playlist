require "httparty"

class PlaylistService
  include HTTParty
  base_uri "https://api.spotify.com/v1/recommendations/available-genre-seeds/"
<<<<<<< HEAD

  # this method gives you a list of genres that exists in spotify
=======
  @token = "BQBblZTBx6xJSK9G0HdLSBzbldUd14Z737NCDqzouZ57FVOcvq_p28SlF1MPYy2ey7pOJvkwAg9Qh3r7cvc"

  #this method gives you a list of genres that exists in spotify
>>>>>>> 15a788c6ae150490865158c279808ebea6cad711
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
    # to prove this methos use the hardcode
  end
end
