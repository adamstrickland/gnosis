class S3Filesystem
  def initialize
    # need to figure out a better set of env vars;
    # these can clash with any set locally, and first-set wins, so
    # the locally-set env vars win out over what's in .env* files
    @client = ::Aws::S3::Client.new region: ENV.fetch("GNOSIS_AWS_REGION", "us-east-1"),
                                    access_key_id: ENV.fetch("GNOSIS_AWS_ACCESS_KEY_ID"),
                                    secret_access_key: ENV.fetch("GNOSIS_AWS_SECRET_ACCESS_KEY")
    bucket_name = ENV.fetch("GNOSIS_AWS_S3_BUCKET", "gnosis-files")
    @bucket = @client.list_buckets.buckets.find{ _1["name"] == bucket_name }
  end

  def paths
    nodes.map do |node|
      node["key"]
    end
  end

  private

  attr_reader :client,
              :bucket

  def object_list
    client.list_objects_v2(bucket: bucket["name"])
  end

  def nodes
    object_list["contents"]
  end
end
