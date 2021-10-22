require 'dotenv/load'
require 'open-uri'
require 'json'

module FlickrHelpers
  def flick_api_body
    @flick_api_body ||= JSON.parse(flickr_api_call)
  end

  def flickr_api_call
    URI.parse(flickr_api_url).open.read
  end

  def flickr_api_key
    ENV['FLICKR_API_KEY']
  end
end
