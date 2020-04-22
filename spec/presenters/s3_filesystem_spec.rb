require "rails_helper"

RSpec.describe S3Filesystem do
  let(:instance) { described_class.new }

  describe "#paths" do
    subject { instance.paths }

    let(:fixture_file_name) { "spec/fixtures/s3_response.json" }
    let(:fixture_file_path) { Rails.root.join(fixture_file_name) }
    let(:fixture_file_data) { File.read(fixture_file_path) }
    let(:fixture) { JSON.parse(fixture_file_data) }

    let(:bucket_name) { "some-bucket-name" }
    let(:buckets) { [ { "name" => bucket_name } ] }

    let(:s3_client) { instance_double(::Aws::S3::Client) }

    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with("GNOSIS_AWS_S3_BUCKET", any_args){ bucket_name }
      allow(::Aws::S3::Client).to receive(:new) { s3_client }
      allow(s3_client).to receive(:list_buckets) do
        double(buckets: buckets)
      end
      allow(s3_client).to receive(:list_objects_v2){ fixture }
    end

    it { is_expected.to be_an Array }
    it { expect(subject.size).to eq fixture["contents"].size }
  end
end
