lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

$LOAD_PATH.unshift(lib_path)

require 'yaml'
require 'extract_labels_from_image'

if ARGV[0].nil?
  print "Usage: #{$PROGRAM_NAME} image_url"
  exit 1
end

backend_file = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../data/images_with_labels.yaml'
  )
)

File.open(backend_file, 'w') { |f| f.write("---\nitems: []") } if !File.exist?(backend_file)

backend = YAML.load_file(backend_file)

image_url = ARGV[0]
description = ARGV[1]

labels = ExtractLabelsFromImage.new(image_url).perform

backend['items'] << {
  image_url: image_url,
  description: description,
  labels: labels,
}.compact

File.open(backend_file, 'w') { |f| f.write(backend.to_yaml) }
