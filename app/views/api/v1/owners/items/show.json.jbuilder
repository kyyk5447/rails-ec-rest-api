json.id @item.id
json.itemCategories @item.item_categories do |category|
  json.id category.id
  json.name category.name
end
json.imageUrl @item.image_url || ''
json.name @item.name
json.description @item.description
json.price @item.price
json.stock @item.stock
json.status @item.status_before_type_cast
json.createdAt @item.created_at

json.shop do
  json.id @item.shop.id
  json.name @item.shop.name
  json.description @item.shop.description
end
