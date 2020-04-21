class BrowseController < ApplicationController
  def index
    context = {}

    presenter = ::BrowserPresenter.new(context)

    @filesystem = presenter.call
  end
end
