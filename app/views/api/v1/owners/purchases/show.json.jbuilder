json.id @purchase.id
json.purchasedAt @purchase.created_at.strftime('%Y-%m-%d %H:%M')
json.memberName "#{@purchase.member.last_name} #{@purchase.member.first_name}"

json.items @purchase.purchase_items.map { |pi|
  item = pi.item
  {
    id: item.id,
    name: item.name,
    quantity: pi.quantity,
    price: item.price,
    subtotal: pi.subtotal
  }
}

json.totalItems @purchase.purchase_items.sum(:quantity)
json.totalAmount @purchase.purchase_items.sum(:subtotal)
