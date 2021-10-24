require 'spec_helper'

RSpec.describe TweetPlatane do
  describe '#perform' do
    subject { described_class.new(date).perform }

    let(:date) { '2021-10-24' }

    let(:twitter_client) { double('twitter_client') }
    let(:valid_image) do
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../images/#{date}.jpg"
        )
      )
    end
    let(:valid_text) { "Stella\nhttps://www.bonjourplatane.fr/2021/10/24/stella.html\n\nCrédits: Rüdiger Stehn ( https://www.flickr.com/people/rstehn/ )"}

    before do
      allow_any_instance_of(described_class).to receive(:client).and_return(twitter_client)

      twitter_client.stub(:update_with_media) do |text, image|
        @text = text
        @image = image
      end
    end

    it 'calls twitter client update_with_media method with valid text and image' do
      subject

      expect(@image).to be_an_instance_of(File)
      expect(@image.path).to eq(File.open(valid_image, 'r').path)

      expect(@text).to eq(valid_text)
    end
  end
end
