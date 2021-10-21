require "dotenv/load"
require "google/cloud/vision"

class ExtractLabelsFromImage
  attr_reader :image_url

  def initialize(image_url)
    @image_url = image_url
  end

  def perform
    raw_labels.each_with_object({}) do |annotation, hash|
      hash[annotation.description] = annotation.score
    end
  end

  private

  def raw_labels
    @raw_labels ||= client.label_detection(image: image_url).responses.first.label_annotations
  end

  def client
    @client ||= Google::Cloud::Vision.image_annotator
  end
end
