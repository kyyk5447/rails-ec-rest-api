json.id @shop.id

json.shopCategories @shop.shop_categories do |category|
  json.id category.id
  json.name category.name
end

json.imageUrl @shop.image_url || ''
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
