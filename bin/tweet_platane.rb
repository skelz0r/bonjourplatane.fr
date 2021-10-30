require 'date'

lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

if ARGV[0].nil?
  print "Usage: #{$PROGRAM_NAME} date"
  exit 1
else
  begin
    date = Date.parse(ARGV[0])
  rescue Date::Error
    print "Invalid date"
    exit 2
  end
end

date_string = date.strftime('%Y-%m-%d')

$LOAD_PATH.unshift(lib_path)

require 'tweet_platane'

tweet = TweetPlatane.new(date_string).perform

if tweet
  print "URI: #{tweet.uri}\n\n"
  print "Text: #{tweet.text}"
else
  print 'No platane to tweet'
  exit 3
end
