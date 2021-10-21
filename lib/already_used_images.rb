require 'abstract_list_images'

class AlreadyUsedImages < AbstractListImages
  def file_name
    'used.txt'
  end
end
