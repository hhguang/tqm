json.array!(@reports) do |report|
  json.extract! report, :title, :exam_id, :school_id, :user_id, :file, :file_name, :subject_name, :group_name
  json.url report_url(report, format: :json)
end
