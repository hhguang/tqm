json.array!(@replies) do |reply|
  json.extract! reply, :content, :user_id, :article_id
  json.url reply_url(reply, format: :json)
end
