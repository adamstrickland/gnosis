require "rails_helper"

RSpec.feature "Browse files:" do
  # Forcing use of S3 here as the test environment by default uses the :test
  # configuration for ActiveStorage, which in turn uses the local
  # filesystem.  For most of our tests, that's exactly what we want, but for
  # this one we want to show that the connection itself works.
  #
  # If this feature is failing, it is likely due to one of the following:
  #
  # 1. The S3 Bucket doesn't exist: verify that the configured S3 bucket
  # exists.  This is configured via the `GNOSIS_AWS_S3_BUCKET`; if none has
  # been set, the default is `gnosis-files-test`.
  # 1. The AWS Credentials are incorrect: check that the session has
  # `GNOSIS_AWS_SECRET_KEY_ID` and `GNOSIS_AWS_SECRET_ACCESS_KEY`
  # environment variables configured, that they are correct for the intended
  # user.
  # 1. The AWS Permissions are incorrect: verify that the AWS user has
  # `s3:ListBucket`, `s3:PutObject`, `s3:GetObject`, and `s3:DeleteObject`
  # permissions for the S3 bucket.
  # 1. The S3 Bucket does not have the expected structure: verify that the AWS
  # bucket has at least 2 directories immediately under it, one named
  # `marketing` and the second `technology`.
  feature "Given a filesystem in S3" do
    before do
      allow(Rails.application.config.active_storage).to receive(:service) { :amazon }
    end

    feature "When I go to /files" do
      before do
        visit "/browse"
      end

      scenario "Then I should see the filesystem" do
        expect(page).to have_link "marketing"
        expect(page).to have_link "technology"
      end
    end
  end
end
