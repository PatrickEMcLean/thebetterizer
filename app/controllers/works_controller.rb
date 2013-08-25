class WorksController < ApplicationController
  def index
    @works = role_action_scope[current_user.highest_role]["index"]
    render role_action_view[current_user.highest_role]["index"]
  end

  def new
  end

  def show
    @work = Work.find(params[:id])
    render role_action_view[current_user.highest_role]["show"]
  end

  def create
    doc_info = create_google_doc
    gd_client.invite_admins(doc_info.data["id"])
    @work = Work.new(params[:work])
    @work.document_url = doc_info.data["alternate_link"]
    @work.google_file_id = doc_info.data["id"]
    @work.status = :created_not_authorized
    @work.save
    flash[:success] = "Congratulations! You've submitted work for us!"
    redirect_to work_path(@work.id)
  end

  private

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

  def role_action_view
    {
      "admin" => {
        "index" => "admin_index",
        "show" => "admin_show"
      },
      "coach" => {
        "index" => "coach_index",
        "show" => "coach_show"
      },
      "user" => {
        "index" => "index",
        "show" => "show"
      },
    }
  end

  def role_action_scope
    {
      "admin" => {
        "index" => Work.all
      },
      "coach" => {
        "index" => Work.for_coach(current_user)
      },
      "user" => {
        "index" => Work.for_user(current_user)
      }
    }
  end
end
