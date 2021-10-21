require 'open-uri'
require 'json'
require 'dotenv/load'

class GetPlataneImage
  def perform
    photo = extract_valid_photo

    {
      'photo_url' => "https://live.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_b.jpg",
      'user_profile_url' => "https://www.flickr.com/people/#{photo['owner']}"
    }
  end

  private

  def extract_valid_photo
    api_body['photos']['photo'].sample
  end

  def api_body
    JSON.parse(api_call)
  end

  def api_call
    URI.parse(api_url).open.read
  end

  def api_url
    "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=#{text}&format=json&nojsoncallback=1&sort=relevance&api_key=#{api_key}&license=#{license_ids}&per_page=#{per_page}&geo_context=2"
  end

  def text
    'platane'
  end

  def license_ids
    %w[
      1
      2
      3
      4
      5
      6
      7
      9
      10
    ].join(',')
  end

  def per_page
    100
  end

  def api_key
    ENV['FLICKR_API_KEY']
  end
end
