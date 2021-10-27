require 'singleton'
require 'yaml'

class ImagesWithLabels
  include Singleton

  attr_reader :backend

  def self.data
    instance.backend
  end

  def self.save!
    instance.save!
  end

  def save!
    File.open(file_path, 'w') { |f| f.write(backend.to_yaml) }
    load_backend!
  end

  private

  def initialize
    load_backend!
    super
  end

  def load_backend!
    @backend ||= YAML.load_file(file_path)
  end

  def file_path
    absolute_file_path("../data/images_with_labels.yaml")
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
