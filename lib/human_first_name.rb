require 'open-uri'
require 'json'
require 'digest'

class HumanFirstName
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def get
    api_body['results'][0]['name']['first']
  end

  private

  def api_body
    JSON.parse(api_call)
  end

  def api_call
    URI.parse(api_url).open.read
  end

  def api_url
    "https://randomuser.me/api/?nat=fr&seed=#{seed}"
  end

  def seed
    date.strftime('%Y%m%d')
  end
end
