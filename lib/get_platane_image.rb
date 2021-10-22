require 'flickr_helpers'
require 'already_used_images'
require 'blacklist_images'

class GetPlataneImage
  include FlickrHelpers

  attr_reader :interactive

  def initialize(interactive: false)
    @interactive = interactive
  end

  def perform
    photo = extract_valid_photo

    add_photo_as_used(photo)

    {
      'photo_url' => build_photo_url(photo),
      'user_id' => photo['owner']
    }
  end

  private

  def build_photo_url(photo)
    "https://live.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_b.jpg"
  end

  def extract_valid_photo
    if interactive
      photo = elligible_photos.sample

      print "Photo: #{build_photo_url(photo)}\nKeep it ? (y/N)"
      answer = STDIN.gets

      if answer.chomp.downcase == 'y'
        photo
      else
        mark_photo_as_blacklisted(photo)
        extract_valid_photo
      end
    else
      elligible_photos.sample
    end
  end

  def elligible_photos
    flick_api_body['photos']['photo'].reject do |photo|
      blacklist?(photo) ||
        already_used?(photo)
    end
  end

  def flickr_api_url
    "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=#{text}&format=json&nojsoncallback=1&sort=relevance&api_key=#{flickr_api_key}&license=#{license_ids}&per_page=#{per_page}&geo_context=2"
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

  def add_photo_as_used(photo)
    AlreadyUsedImages.instance.add(build_photo_url(photo))
  end

  def mark_photo_as_blacklisted(photo)
    BlacklistImages.instance.add(build_photo_url(photo))
  end

  def blacklist?(photo)
    BlacklistImages.instance.include?(build_photo_url(photo))
  end

  def already_used?(photo)
    AlreadyUsedImages.instance.include?(build_photo_url(photo))
  end

  # 500 = Max
  def per_page
    100
  end
end
