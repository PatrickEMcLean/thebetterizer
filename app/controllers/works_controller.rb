
class WorksController < ApplicationController
  def index
    # show work you have submitted or the work you are assigned.
    text = ""
    GoogleDriveClient.new(current_user).files.items.each do |f|
      text += "#{f["id"]}<br/>"
    end
    render text: text
  end

  def new

  end

  def create
    doc_info = create_google_doc
    Rails.logger.info doc_info.data.inspect
    gd_client.invite_admins(doc_info.data["id"])
    # save the work
    # report any errors
    #
    render :text => doc_info.data.to_hash.inspect
  end

  def create_google_doc
    uploaded_file = params[:work][:temp_document]
    gd_client.upload!(uploaded_file, "wewt")
  end

  def gd_client
    @gd_client ||= GoogleDriveClient.new(current_user)
  end
end
