require 'date'

interative = ARGV[1].nil?

lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

if ARGV[0]
  begin
    date = Date.parse(ARGV[0])
  rescue Date::Error
    print "Invalid date"
    exit 1
  end
else
  date = Date.today
end

$LOAD_PATH.unshift(lib_path)

require 'generate_platane_post'

GeneratePlatanePost.new(date, interactive: interative).perform
