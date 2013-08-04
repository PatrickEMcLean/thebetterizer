class WorksController < ApplicationController
  def index
    # show work you have submitted or the work you are assigned.
  end

  def new

  end

  def create
    # create the google document
    doc_link = create_google_doc
    # save the work
    # report any errors
    #
  end

  def create_google_doc
    
  end
end
