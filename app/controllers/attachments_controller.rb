class AttachmentsController < ApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    send_file @attachment.file.current_path, :filename=>@attachment.file_name
  end
end
