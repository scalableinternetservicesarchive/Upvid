json.array!(@videos) do |video|
  json.extract! video, :id, :title, :category
  json.url video_url(video, format: :json)
end
