
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
    gd_client.invite_admins(doc_info.data["id"])
    @work = Work.new(params[:work])
    @work.document_url = doc_info.data["alternate_link"]
    @work.google_file_id = doc_info.data["id"]
    @work.save
    render :text => @work.inspect
  end

  def create_google_doc
    uploaded_file = params[:work][:temp_document]
    gd_client.upload!(uploaded_file, "wewt")
  end

  def gd_client
    @gd_client ||= GoogleDriveClient.new(current_user)
  end
end
