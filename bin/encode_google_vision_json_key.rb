require 'base64'

json_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../secrets/google-vision.json'
  )
)

print Base64.urlsafe_encode64(File.read(json_path))
