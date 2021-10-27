lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

$LOAD_PATH.unshift(lib_path)

require 'extract_labels_from_image'
require 'images_with_labels'

if ARGV[0].nil?
  print "Usage: #{$PROGRAM_NAME} image_url"
  exit 1
end

image_url = ARGV[0]
description = ARGV[1]

image_already_analysed = ImagesWithLabels.data['items'].any? { |item| item[:image_url] == image_url }

if image_already_analysed
  print "Image already analysed"
  exit 2
end

labels = ExtractLabelsFromImage.new(image_url).perform

ImagesWithLabels.data['items'] << {
  image_url: image_url,
  description: description,
  labels: labels,
}.compact

ImagesWithLabels.save!
