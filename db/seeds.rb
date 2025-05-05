# db/seeds.rb

# 🔄 初期化
puts "Seeding data..."
CartItem.delete_all
Cart.delete_all
FavoriteItem.delete_all
PurchaseItem.delete_all
Purchase.delete_all
Review.delete_all
ShippingInfo.delete_all
Item.delete_all
Shop.delete_all
Owner.delete_all
Member.delete_all

# 🧑‍💼 Owner と Shop
owner = Owner.create!(
  email: "owner@example.com",
  password: "password",
  first_name: "太郎",
  last_name: "山田",
  first_name_kana: "タロウ",
  last_name_kana: "ヤマダ"
)

shop = Shop.create!(
  name: "モードスタイル",
  description: "最新トレンドを取り入れたアパレルショップ",
  owner: owner
)

# 🧑‍💻 Member（必須属性あり）
member = Member.create!(
  email: "member@example.com",
  password: "password",
  first_name: "花子",
  last_name: "佐藤",
  first_name_kana: "ハナコ",
  last_name_kana: "サトウ",
  tel: "09012345678",
  gender: 1,
  birthday: Date.new(1990, 1, 1)
)

# 🚚 ShippingInfo
ShippingInfo.create!(
  member: member,
  postal_code: "150-0001",
  country: "日本",
  prefecture: "東京都",
  city: "渋谷区",
  address: "神宮前1-1-1",
  building: "モードビル5F"
)

# 🧥 Items（アパレル商品を10件）
items = [
  { name: "ベーシックTシャツ", price: 1980, stock: 100, description: "着回し抜群のコットンTシャツ" },
  { name: "オーバーサイズパーカー", price: 4980, stock: 50, description: "ゆったりシルエットでこなれ感UP" },
  { name: "デニムパンツ", price: 6980, stock: 60, description: "ストレートカットの定番デニム" },
  { name: "チェック柄シャツ", price: 3980, stock: 40, description: "秋冬にぴったりなチェック柄" },
  { name: "マキシワンピース", price: 7980, stock: 30, description: "エレガントなロング丈ワンピース" },
  { name: "レザージャケット", price: 12980, stock: 20, description: "スタイリッシュなライダースジャケット" },
  { name: "ニットセーター", price: 5980, stock: 35, description: "暖かくて柔らかいウールニット" },
  { name: "プリーツスカート", price: 4580, stock: 45, description: "上品な揺れ感が魅力のスカート" },
  { name: "テーラードジャケット", price: 9980, stock: 25, description: "ビジネスにもカジュアルにも使える一枚" },
  { name: "サマーハット", price: 2480, stock: 80, description: "夏の紫外線対策にぴったりな帽子" }
]

items.each do |item_data|
  Item.create!(
    name: item_data[:name],
    description: item_data[:description],
    price: item_data[:price],
    stock: item_data[:stock],
    status: 1,
    shop: shop
  )
end

# 🛒 Cart & CartItem
cart = Cart.create!(member: member)
CartItem.create!(cart: cart, item: Item.first, quantity: 1)

# ❤️ FavoriteItem
FavoriteItem.create!(member: member, item: Item.last)

# 💰 Purchase & PurchaseItem
purchase = Purchase.create!(
  member: member,
  total_price: Item.first.price + Item.last.price
)

PurchaseItem.create!(
  purchase: purchase,
  item: Item.first,
  quantity: 1,
  subtotal: Item.first.price
)

PurchaseItem.create!(
  purchase: purchase,
  item: Item.last,
  quantity: 1,
  subtotal: Item.last.price
)

# ✍️ Review
Review.create!(
  member: member,
  item: Item.first,
  title: "気に入りました！",
  comment: "シンプルで着心地も良く、何枚も欲しくなります。",
  rating: 5
)

puts "✅ Done!"