class FilesystemService
  LOCAL_SERVICES = %i[test local].freeze
  CONFIG_FILE_NAME = "storage.yml"

  def call
    if local?
      local
    else
      s3
    end
  end

  private

  def configured_service
    Rails.application.config.active_storage.service
  end

  def s3
    ::S3Filesystem.new
  end

  def local
    ::LocalFilesystem.new(File.expand_path(local_path))
  end

  def local?
    LOCAL_SERVICES.include?(configured_service)
  end

  def local_path
    return nil if local_path_root.blank?

    File.expand_path(local_path_root)
  end

  def local_path_root
    configured_configuration["root"]
  end

  def configured_configuration
    parsed_configuration[configured_service.to_s]
  end

  def parsed_configuration
    YAML.load(processed_configuration)
  end

  def processed_configuration
    ERB.new(config_file_contents).result
  end

  def config_file_contents
    File.read(config_file_path)
  end

  def config_file_path
    Rails.root.join(config_file_relative_path)
  end

  def config_file_relative_path
    "config/#{CONFIG_FILE_NAME}"
  end
end
