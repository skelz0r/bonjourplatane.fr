require 'open-uri'
require 'json'
require 'dotenv/load'

class GetPlataneImage
  def perform
    photo = extract_valid_photo

    {
      'url' => "https://live.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
    }
  end

  private

  def extract_valid_photo
    api_body['photos']['photo'].first
  end

  def api_body
    JSON.parse(api_call)
  end

  def api_call
    URI.parse(api_url).open.read
  end

  def api_url
    "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=platane&format=json&nojsoncallback=1&api_key=#{api_key}"
  end

  def api_key
    ENV['FLICKR_API_KEY']
  end
end
