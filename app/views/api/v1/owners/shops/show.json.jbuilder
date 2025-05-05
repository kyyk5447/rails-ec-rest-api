json.id @shop.id
json.imageUrl @shop.image_url
json.name @shop.name
json.description @shop.description
json.createdAt @shop.created_at

json.items @shop.items do |item|
  json.id item.id
  json.name item.name
  json.price item.price
  json.description item.description
  json.createdAt item.created_at
end