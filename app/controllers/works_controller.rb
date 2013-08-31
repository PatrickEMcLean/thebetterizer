class WorksController < ApplicationController
  def index
    @works = role_action_scope[current_user.highest_role]["index"]
    render role_action_view[current_user.highest_role]["index"]
  end

  def new
  end

  def update
    work = Work.find(params[:id])
    if work.update_attributes(params[:work])
      flash[:success] = "Work has been updated successfully"
    else
      flash[:error] = "There was an error updating the work."
    end
    redirect_to work_path(work)
  end

  def show
    @work = Work.find(params[:id])
    render role_action_view[current_user.highest_role]["show"][@work.current_status.status]
  end

  def create
    doc_info = create_google_doc
    gd_client.invite_admins(doc_info.data["id"])
    @work = Work.new(params[:work])
    @work.user_id = current_user.id
    @work.document_url = doc_info.data["alternate_link"]
    @work.google_file_id = doc_info.data["id"]
    @work.status = :created_not_authorized
    @work.save
    flash[:success] = "Congratulations! You've submitted work for us!"
    redirect_to work_path(@work.id)
  end

  private

  def create_google_doc
    uploaded_file = params[:work][:temp_document] ||
      StringFile.new(params[:work][:temp_text])
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
        "show" => {
          "created_not_authorized"    => "admin_show",
          "authorized"                => "admin_show",
          "in_progress"               => "admin_show",
          "coaching_complete"         => "admin_show",
          "approved"                  => "admin_show",
          "payment_pending"           => "admin_show",
          "paid"                      => "admin_show",
          "delivered"                 => "admin_show",
          "student_feedback complete" => "admin_show",
          "complete"                  => "admin_show"
        }
      },
      "coach" => {
        "index" => "coach_index",
        "show" => {
          "created_not_authorized"    => "coach_show",
          "authorized"                => "coach_show",
          "in_progress"               => "coach_show",
          "coaching_complete"         => "coach_show",
          "approved"                  => "coach_show",
          "payment_pending"           => "coach_show",
          "paid"                      => "coach_show",
          "delivered"                 => "coach_show",
          "student_feedback complete" => "coach_show",
          "complete"                  => "coach_show"
        }
      },
      "user" => {
        "index" => "index",
        "show" => {
          "created_not_authorized"    => "student_payment_form",
          "authorized"                => "student_work_begun",
          "in_progress"               => "student_work_begun",
          "coaching_complete"         => "student_work_begun",
          "approved"                  => "student_processing_payment",
          "paid"                      => "student_processing_payment",
          "delivered"                 => "student_feedback",
          "student_feedback complete" => "student_show",
          "complete"                  => "student_show"
        }
      },
    }.with_indifferent_access
  end

  def role_action_scope
    {
      "admin" => {
        "index" => Work.for_admin
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
