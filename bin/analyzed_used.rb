used_file = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../data/used.txt'
  )
)

used = File.readlines(used_file)

used.each do |link|
  print "Process: #{link}\n"
  `ruby bin/save_labels_for_image.rb #{link.strip} 'VALID'`
end
