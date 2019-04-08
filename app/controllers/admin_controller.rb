class AdminController < ApplicationController
  def index
    @rates = Rate.all
  end
end
