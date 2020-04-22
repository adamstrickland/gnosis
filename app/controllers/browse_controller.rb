class BrowseController < ApplicationController
  def index
    filesystem = FilesystemService.new.call
    presenter = ::BrowserPresenter.new(filesystem)

    @filesystem = presenter.call
  end
end
