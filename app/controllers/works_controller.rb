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
    @work.status = :created_not_authorized
    @work.save
    flash[:success] = "Congratulations! You have uploaded work for us to do!"
    redirect_to work_path(@work.id)
  end

  def create_google_doc
    uploaded_file = params[:work][:temp_document] || StringFile.new(params[:work][:temp_text])
    description = <<-description
      Audience: #{params[:work][:student_audience]}
      Desired Outcome: #{params[:work][:student_desired_outcome]}
      What I'm trying to say: #{params[:work][:student_essence]}
    description
    gd_client.upload!(uploaded_file, description)
  end

  def gd_client
    @gd_client ||= GoogleDriveClient.new(current_user)
  end
end
