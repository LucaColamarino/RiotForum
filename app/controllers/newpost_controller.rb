class NewpostController < ApplicationController
  def index
    @newpost=Newpost.all
  end

  def create
  end

end
