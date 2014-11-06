json.array!(@comments) do |comment|
  json.extract! comment, :id, :message
  json.url comment_url(comment, format: :json)
end
