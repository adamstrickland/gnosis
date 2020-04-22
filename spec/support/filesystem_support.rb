module FilesystemSupport
  class StaticFilesystem
    attr_reader :paths

    def initialize(paths)
      @paths = paths
    end
  end

  def static_filesystem(paths)
    StaticFilesystem.new(paths)
  end

  def local_filesystem(path_to_directory)
    LocalFilesystem.new(path_to_directory)
  end
end

RSpec.configure do |config|
  config.include(FilesystemSupport)
end
