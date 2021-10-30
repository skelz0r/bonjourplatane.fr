require 'dotenv/load'
require 'twitter'

class TweetPlatane
  attr_reader :date

  def initialize(date)
    @date = Date.parse(date)
  end

  def perform
    return unless platane_exists?

    client.update_with_media(
      text,
      image
    )
  end

  def text
    "#{name}\n#{link}\n\n#{credits}"
  end

  def image
    File.open(image_path, 'r')
  end

  private

  def platane_exists?
    File.exist?(image_path)
  end

  def date_dashed
    @date_dashed ||= date.strftime('%Y-%m-%d')
  end

  def name
    @name ||= post_content.split("\n").find { |str| str.start_with?('title: ') }.gsub('title: ', '')
  end

  def link
    "https://www.bonjourplatane.fr/#{date.strftime('%Y/%m/%d')}/#{name.downcase}.html"
  end

  def credits
    "Crédits: #{author_name} ( #{author_link} )"
  end

  def post_content
    @post_content ||= File.read(post_path)
  end

  def author_name
    credits_line.match(/\[(.+)\]/)[1]
  end

  def author_link
    credits_line.match(/\((.+)\)/)[1]
  end

  def credits_line
    @credits_line ||= post_content.split("\n").find { |str| str.start_with?('Crédits') }
  end

  def image_path
    absolute_file_path("../images/#{date_dashed}.jpg")
  end

  def post_path
    Dir["#{absolute_file_path("../_posts/#{date_dashed}-*.md")}"].first
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def absolute_file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end
end
