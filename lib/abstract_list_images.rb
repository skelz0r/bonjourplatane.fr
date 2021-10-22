require 'singleton'

class AbstractListImages
  include Singleton

  def add(string)
    return if include?(string)

    @backend << string
    File.open(file_path, 'a') { |f| f.write(string) }
  end

  def include?(string)
    @backend.include?(string)
  end

  protected

  def file_name
    fail NotImplementedError
  end

  private

  def initialize
    load_backend!
    super
  end

  def load_backend!
    @backend ||= File.readlines(file_path).map(&:strip)
  end

  def file_path
    absolute_file_path("../data/#{file_name}")
  end

  def absolute_file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end
end
