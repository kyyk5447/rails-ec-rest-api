json.array!(@shipping_info) do |shipping_info|
  json.id shipping_info.id
  json.postalCode shipping_info.postal_code
  json.country shipping_info.country
  json.prefecture shipping_info.prefecture
  json.city shipping_info.city
  json.building shipping_info.building
end