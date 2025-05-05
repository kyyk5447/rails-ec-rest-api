json.purchases do
  json.array! @purchases do |purchase|
    json.id purchase.id
    json.totalPrice purchase.total_price
    json.createdAt purchase.created_at
  
    json.purchaseItems purchase.purchase_items do |purchase_item|
      json.id purchase_item.id
      json.quantity purchase_item.quantity
      json.subtotal purchase_item.subtotal
  
      json.item do
        item = purchase_item.item
        json.id item.id
        json.imageUrl item.image_url || ''
        json.name item.name
        json.description item.description
        json.price item.price
        json.stock item.stock
        json.status item.status_before_type_cast
        json.shopId item.shop_id
      end
    end
  end
end

json.totalPages @purchases.total_pages
json.totalCount @purchases.total_count
json.currentPage @purchases.current_page
json.nextPage @purchases.next_page
json.hasNext @purchases.next_page.present?

