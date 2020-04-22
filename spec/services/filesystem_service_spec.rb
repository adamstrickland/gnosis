require "rails_helper"

RSpec.describe FilesystemService do
  let(:instance) { described_class.new }

  describe "#call" do
    subject { instance.call }

    context "when Rails is configured to use s3" do
      before do
        allow(Rails.application.config.active_storage).to receive(:service) { :amazon }
      end

      it { is_expected.to be_an ::S3Filesystem }
    end

    context "when Rails is configured to use the local filesystem" do
      it { is_expected.to be_a ::LocalFilesystem }
    end

    context "when Rails is configured to use something else" do
      it { is_expected.to be_a ::LocalFilesystem }
    end
  end
end
