require 'spec_helper'
require "google/cloud/vision/v1"

RSpec.describe ExtractLabelsFromImage do
  describe '#perform' do
    subject { ExtractLabelsFromImage.new('https://www.google.fr/image.png').perform }

    let(:google_cloud_vision_responses) do
      Google::Cloud::Vision::V1::BatchAnnotateImagesResponse.new(
        responses: [
          Google::Cloud::Vision::V1::AnnotateImageResponse.new(
            label_annotations: [
              Google::Cloud::Vision::V1::EntityAnnotation.new(
                description: 'Tree',
                score: 0.9
              ),
              Google::Cloud::Vision::V1::EntityAnnotation.new(
                description: 'Human',
                score: 0.5
              ),
            ]
          )
        ]
      )
    end

    before do
      allow_any_instance_of(described_class).to receive(:client).and_return(
        double('client', label_detection: google_cloud_vision_responses)
      )
    end

    it do
      expect(subject.keys).to contain_exactly('Tree', 'Human')

      expect(subject['Tree']).to be_within(0.1).of(0.9)
      expect(subject['Human']).to be_within(0.1).of(0.5)
    end
  end
end
