require "rails_helper"
require "file_tree"

RSpec.describe FileTree do
  let(:instance) { described_class.new }

  describe "#add_path!" do
    subject do
      instance.add_path!(path)
    end

    context "when the path is just '/'" do
      let(:path) { "/" }

      it "should not change anything" do
        expect do
          subject
        end.not_to change{ instance.size }
      end
    end

    context "when the path is /foo" do
      let(:path) { "/foo" }

      it "should add a 'foo' node to the root" do
        expect do
          subject
        end.to change{ instance.size }.from(1).to(2)
      end
    end

    context "when the path is /foo/bar" do
      let(:path) { "/foo/bar" }
      let(:parent_path) { "/foo" }

      context "and /foo exists" do

        before do
          instance.add_path!("/foo")
        end

        it "should add a node to the tree" do
          expect do
            subject
          end.to change{ instance.size }.from(2).to(3)
        end

        it "should add a 'bar' node to the 'foo' node" do
          parent = instance.node_at_path(parent_path)

          expect(parent.path_as_string(described_class::SEPARATOR)).to eq parent_path

          expect do
            subject
          end.to change{ parent.children.size }.from(0).to(1)
        end
      end

      xcontext "and /foo does not exist" do
        before do
          expect(instance.at(parent_path)).to be_nil
        end

        it "should add 2 nodes to the tree" do
          expect do
            subject
          end.to change{ instance.size }.from(1).to(3)
        end

        xit "should add a 'foo' node to the root" do

        end

        xit "should add a 'bar' node to the 'foo' node" do

        end
      end
    end
  end
end
