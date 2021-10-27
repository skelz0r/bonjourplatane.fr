lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

$LOAD_PATH.unshift(lib_path)

require 'images_with_labels'
require 'analyze_image'

ImagesWithLabels.data['items'].each do |item|
  analyze = AnalyzeImage.new(item[:labels])
  status_string = analyze.valid? ? 'OK' : 'NOK'

  print "URL: #{item[:image_url]}\nDescription: #{item[:description]}\nStatus: #{status_string}\n\n"
end
