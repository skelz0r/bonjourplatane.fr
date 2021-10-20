lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

$LOAD_PATH.unshift(lib_path)

require 'generate_platane_post'

date = Date.new(2021, 10, 19)
GeneratePlatanePost.new(date).perform
