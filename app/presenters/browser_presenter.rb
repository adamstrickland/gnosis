require "aws-sdk"
require "file_tree"

class BrowserPresenter
  class FilesystemArgumentError < ArgumentError
    def initialize(fs)
      super("#{fs.class.to_s} must respond to :paths")
    end
  end

  def initialize(filesystem)
    raise FilesystemArgumentError.new unless filesystem.respond_to?(:paths)

    @filesystem = filesystem
  end

  def call
    file_tree.to_h[FileTree::ROOT]
  end

  private

  def file_tree
    @file_tree ||= begin
                     fs = FileTree.new

                     @filesystem.paths.each do |key|
                       fs.add_path!(key)
                     end

                     fs
                   end
  end
end
