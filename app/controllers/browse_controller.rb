class BrowseController < ApplicationController
  def index
    filesystem = ::S3Filesystem.new
    presenter = ::BrowserPresenter.new(filesystem)

    @filesystem = presenter.call
  end
end
