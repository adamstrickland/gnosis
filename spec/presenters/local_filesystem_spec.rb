require "rails_helper"

RSpec.describe LocalFilesystem do
  let(:instance) { described_class.new(path) }
  let(:path) { Rails.root.join("spec/fixtures/local_filesystem") }

  describe "#paths" do
    subject { instance.paths }

    it { is_expected.to be_an Array }
    it { expect(subject.size).to eq 5 }
  end
end
