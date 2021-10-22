require 'base64'

print Base64.urlsafe_decode64(ARGV[0])
