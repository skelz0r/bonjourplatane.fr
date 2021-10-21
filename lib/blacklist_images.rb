require 'abstract_list_images'

class BlacklistImages < AbstractListImages
  def file_name
    'blacklist.txt'
  end
end
