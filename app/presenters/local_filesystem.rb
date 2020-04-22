class LocalFilesystem
  def initialize(path_to_directory)
    @root_path = path_to_directory
  end

  def paths
    `find #{full_path} | grep -v "^#{full_path}$"`.split(/\n/)
  end

  private

  def full_path
    File.expand_path(@root_path)
  end
end
