require 'google/api_client'

class GoogleDriveClient
  attr_reader :client, :service_account, :user
  def initialize(user)
    @client = Google::APIClient.new
    key = Google::APIClient::PKCS12.load_key("#{Rails.root}/lib/assets/api_key.p12", 'notasecret')
    @service_account = Google::APIClient::JWTAsserter.new(
      Rails.configuration.service_account_id,
      'https://www.googleapis.com/auth/drive',
      key
    )
    @client.authorization = service_account.authorize
    @user = user
  end

  def upload!(file, description)
    Rails.logger.info "metadata: #{metadata(file, description).inspect}"
    results = @client.execute(
      api_method:  drive.files.insert,
      body_object: metadata(file, description),
      media:       Google::APIClient::UploadIO.new(file.tempfile, file.content_type),
      parameters:  { "uploadType" => "multipart", "alt" =>  'json', "convert" => "true"}
    )
  end

  def metadata(file, description)
    drive.files.insert.request_schema.new(
    {
      "title" => "#{user.name} - #{Time.now.strftime("%Y%m%d%H%M%S")} - #{file.original_filename}",
      "description" => description,
      "mimeType" => file.content_type
    }
    )
  end

  def drive
    @client.discovered_api('drive', 'v2')
  end

  def files
    @client.execute(drive.files.list).data
  end

  def insert_permission(file_id, email, role)
    new_permission = drive.permissions.insert.request_schema.new({
      'value' => email,
      'type' => 'user',
      'role' => role
    })
    result = client.execute(
      :api_method => drive.permissions.insert,
      :body_object => new_permission,
      :parameters => { 'fileId' => file_id })
    if result.status == 200
      return result.data
    else
      raise "An error occurred: #{result.data['error']['message']}"
    end

  end

  def invite_admins(file_id)
    Rails.configuration.admin_emails.each do |email|
      self.insert_permission(file_id, email, "writer")
    end
  end
end
