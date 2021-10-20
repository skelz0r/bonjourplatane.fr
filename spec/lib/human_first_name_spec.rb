require 'spec_helper'

RSpec.describe HumanFirstName do
  describe '#get' do
    subject { described_class.new(date).get }

    let(:date) { Date.new(2021, 10, 21) }
    let(:url) { 'https://randomuser.me/api/?gender=male&nat=fr&seed=20211021' }

    let(:stubbed_request) do
      stub_request(:get, url).to_return(
        status: 200,
        body: {
          results: [
            {
              name: {
                first: 'skelz0r'
              }
            }
          ]
        }.to_json
      )
    end

    before do
      stubbed_request
    end

    it { is_expected.to eq('skelz0r') }
  end
end
