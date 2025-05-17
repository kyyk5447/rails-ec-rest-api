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
json.createdAt @item.created_at

json.reviews @item.reviews do |review|
  json.id review.id
  json.title review.title
  json.comment review.comment
  json.rating review.rating
end
