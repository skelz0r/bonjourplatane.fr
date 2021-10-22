require 'flickr_helpers'

class GetImageOwner
  include FlickrHelpers

  attr_reader :id

  def initialize(id)
    @id = id
  end

  def perform
    {
      'url' => flick_api_body['person']['profileurl']['_content'],
      'username' => flick_api_body['person']['username']['_content']
    }
  end

  private

  def flickr_api_url
    "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&user_id=#{id}&format=json&nojsoncallback=1&api_key=#{flickr_api_key}"
  end
end
