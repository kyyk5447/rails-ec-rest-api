json.purchases do
  json.array! @purchases do |purchase|
    json.id purchase.id
    json.purchasedAt purchase.created_at.strftime('%Y-%m-%d %H:%M')
    json.memberName "#{purchase.member.last_name} #{purchase.member.first_name}"

    filtered_items = purchase.purchase_items.select do |pi|
      pi.item.shop_id == params[:shop_id].to_i
    end

    json.totalItems(filtered_items.sum(&:quantity))

    json.totalAmount filtered_items.sum(&:subtotal)
  end
end

json.totalPages @purchases.total_pages
json.totalCount @purchases.total_count
json.currentPage @purchases.current_page
