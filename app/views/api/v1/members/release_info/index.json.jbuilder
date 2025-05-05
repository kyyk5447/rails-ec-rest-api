json.array!(@release_info) do |release_info|
  json.id release_info.id
  json.title release_info.title
  json.body release_info.body
  json.craetedAt release_info.created_at
end
