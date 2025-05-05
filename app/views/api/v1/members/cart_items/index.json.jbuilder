json.array! @cart_items do |cart_item|
  json.id cart_item.item.id
  json.imageUrl cart_item.item.image_url || ''
  json.name cart_item.item.name
  json.description cart_item.item.description
  json.price cart_item.item.price
  json.quantity cart_item.quantity
  json.stock cart_item.item.stock
  json.shopId cart_item.item.shop_id
end
