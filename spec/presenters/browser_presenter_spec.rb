require "rails_helper"

RSpec.describe BrowserPresenter do
  let(:instance) { described_class.new(filesystem) }
  let(:paths) { [] }
  let(:filesystem) { static_filesystem(paths) }

  describe "#call" do
    subject { instance.call }

    let(:paths) do
      [
        "/foo",
        "/bar",
        "/foo/foo.md",
        "/foo/baz",
      ]
    end

    it { is_expected.to be_a Hash }
    it { expect(subject.keys.size).to eq 2 }
    it { expect(subject.keys).to include "foo", "bar" }
    it { expect(subject["foo"].size).to eq 2 }
    it { expect(subject["foo"].keys).to include "foo.md", "baz" }
  end
end
