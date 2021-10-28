require 'extract_labels_from_image'

class AnalyzeImage
  attr_reader :labels

  def initialize(labels)
    @labels = labels
  end

  def valid?
    return false if blacklist_labels.include?(labels.keys)
    return false if threshold_reached?(blacklist_labels_with_threshold)
    return true if threshold_reached?(whitelist_with_threshold)

    false
  end

  private

  def threshold_reached?(list_with_threshold)
    list_with_threshold.any? do |key, threshold|
      !labels[key].nil? &&
        labels[key] >= threshold
    end
  end

  def whitelist_with_threshold
    {
      'Twig' => 0.85,
      'Trunk' => 0.85,
      'Tree' => 0.85,
    }
  end

  def blacklist_labels_with_threshold
    {
      'Car' => 0.9,
      'Art' => 0.8,
    }
  end

  def blacklist_labels
    [
      'Human',
      'Human body',
      'Lip',
      'Hand',
      'Facial expression',
    ]
  end
end
