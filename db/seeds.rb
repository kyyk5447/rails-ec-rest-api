# db/seeds.rb

# 🔄 初期化
puts "\n=== 🌱 Creating seed data... ===\n"
CartItem.delete_all
Cart.delete_all
FavoriteItem.delete_all
PurchaseItem.delete_all
Purchase.delete_all
Review.delete_all
ReleaseInfo.delete_all
ShippingInfo.delete_all
ItemCategoryAssignment.delete_all
Item.delete_all
ShopCategoryAssignment.delete_all
Shop.delete_all
ShopCategory.delete_all
ItemCategory.delete_all
Owner.delete_all
Member.delete_all

# 👤 オーナー作成
puts "Creating owners..."
owner1 = Owner.create!(
  email: 'owner1@example.com',
  password: 'password',
  first_name: '太郎',
  last_name: '山田',
  first_name_kana: 'タロウ',
  last_name_kana: 'ヤマダ'
)

owner2 = Owner.create!(
  email: 'owner2@example.com',
  password: 'password',
  first_name: '次郎',
  last_name: '鈴木',
  first_name_kana: 'ジロウ',
  last_name_kana: 'スズキ'
)

# 👥 会員作成
puts "Creating members..."
member1 = Member.create!(
  email: 'member1@example.com',
  password: 'password',
  first_name: '花子',
  last_name: '佐藤',
  first_name_kana: 'ハナコ',
  last_name_kana: 'サトウ',
  tel: '09012345678',
  gender: 1,
  birthday: Date.new(1990, 1, 1)
)

member2 = Member.create!(
  email: 'member2@example.com',
  password: 'password',
  first_name: '美咲',
  last_name: '田中',
  first_name_kana: 'ミサキ',
  last_name_kana: 'タナカ',
  tel: '09087654321',
  gender: 1,
  birthday: Date.new(1995, 5, 5)
)

# 📦 配送情報
puts "Creating shipping info..."
shipping_info1 = ShippingInfo.create!(
  member: member1,
  postal_code: '150-0001',
  country: '日本',
  prefecture: '東京都',
  city: '渋谷区',
  address: '神宮前1-1-1',
  building: 'ファッションビル5F'
)

shipping_info2 = ShippingInfo.create!(
  member: member2,
  postal_code: '220-0012',
  country: '日本',
  prefecture: '神奈川県',
  city: '横浜市西区',
  address: '南幸2-2-2',
  building: 'ハーバーマンション303'
)

# 🏪 ショップカテゴリー作成
puts "Creating shop categories..."
ShopCategory.find_or_create_by!(id: 1, name: "メンズファッション")
ShopCategory.find_or_create_by!(id: 2, name: "レディースファッション")
ShopCategory.find_or_create_by!(id: 3, name: "キッズファッション")
ShopCategory.find_or_create_by!(id: 4, name: "シューズ")
ShopCategory.find_or_create_by!(id: 5, name: "バッグ")
ShopCategory.find_or_create_by!(id: 6, name: "アクセサリー")
ShopCategory.find_or_create_by!(id: 7, name: "スポーツ")
ShopCategory.find_or_create_by!(id: 8, name: "アウトドア")
ShopCategory.find_or_create_by!(id: 9, name: "コスメ・美容")
ShopCategory.find_or_create_by!(id: 10, name: "ヘルス・ボディケア")
ShopCategory.find_or_create_by!(id: 11, name: "フード・グルメ")
ShopCategory.find_or_create_by!(id: 12, name: "インテリア・雑貨")

# 👕 商品カテゴリー作成
puts "Creating item categories..."
ItemCategory.all_categories.each do |category|
  ItemCategory.find_or_create_by!(id: category.id, name: category.name)
end

# 🏬 ショップ作成
puts "Creating shops..."
mens_shop = Shop.create!(
  owner: owner1,
  name: 'メンズスタイル東京',
  description: '上質な素材とモダンなデザインにこだわった、大人のためのメンズファッションを提供。',
  shop_categories: [ShopCategory.find_by_id(1)] # メンズファッション
)

womens_shop = Shop.create!(
  owner: owner1,
  name: 'レディースコレクション',
  description: '女性の毎日を彩るトレンド感のある商品をセレクト。',
  shop_categories: [ShopCategory.find_by_id(2)] # レディースファッション
)

accessory_shop = Shop.create!(
  owner: owner2,
  name: 'アクセサリーワールド',
  description: 'トレンディで洗練されたアクセサリーを豊富に取り揃えています。',
  shop_categories: [
    ShopCategory.find_by_id(6), # アクセサリー
    ShopCategory.find_by_id(5)  # バッグ
  ]
)

# 👕 商品作成
puts "Creating items..."
mens_item1 = Item.create!(
  shop: mens_shop,
  name: 'クラシックTシャツ',
  description: '上質な綿100%を使用したベーシックなTシャツ',
  price: 3900,
  stock: 50,
  status: :published,
  item_categories: [ItemCategory.find_by_id(ItemCategory::TOPS)]
)

mens_item2 = Item.create!(
  shop: mens_shop,
  name: 'スリムフィットジーンズ',
  description: '履き心地抜群のストレッチデニム',
  price: 8900,
  stock: 30,
  status: :published,
  item_categories: [ItemCategory.find_by_id(ItemCategory::BOTTOMS)]
)

womens_item1 = Item.create!(
  shop: womens_shop,
  name: 'フラワーワンピース',
  description: '春にぴったりの花柄ワンピース',
  price: 12900,
  stock: 20,
  status: :published,
  item_categories: [ItemCategory.find_by_id(ItemCategory::DRESSES)]
)

womens_item2 = Item.create!(
  shop: womens_shop,
  name: 'ニットカーディガン',
  description: '着回しやすい定番カーディガン',
  price: 7900,
  stock: 25,
  status: :published,
  item_categories: [
    ItemCategory.find_by_id(ItemCategory::TOPS),
    ItemCategory.find_by_id(ItemCategory::OUTERWEAR)
  ]
)

accessory_item = Item.create!(
  shop: accessory_shop,
  name: 'シルバーネックレス',
  description: 'シンプルで上品なデザインのネックレス',
  price: 5900,
  stock: 15,
  status: :published,
  item_categories: [ItemCategory.find_by_id(ItemCategory::ACCESSORIES)]
)

shoes_item = Item.create!(
  shop: mens_shop,
  name: 'レザースニーカー',
  description: '上質な本革を使用したスニーカー',
  price: 15900,
  stock: 10,
  status: :published,
  item_categories: [ItemCategory.find_by_id(ItemCategory::SHOES)]
)

# 📢 お知らせ
puts "Creating release info..."
ReleaseInfo.create!(
  shop: mens_shop,
  title: '2024年春夏コレクション入荷',
  body: '待望の春夏コレクションが入荷しました。最新トレンドのアイテムを多数取り揃えております。',
  status: :published
)

ReleaseInfo.create!(
  shop: womens_shop,
  title: '送料無料キャンペーン実施中',
  body: '期間限定で1万円以上のお買い物が送料無料になります。この機会にぜひご利用ください。',
  status: :published
)

# 🛒 カート
puts "Creating carts..."
cart1 = Cart.create!(member: member1)
CartItem.create!(cart: cart1, item: mens_item1, quantity: 1)
CartItem.create!(cart: cart1, item: womens_item1, quantity: 1)

cart2 = Cart.create!(member: member2)
CartItem.create!(cart: cart2, item: accessory_item, quantity: 2)

# ❤️ お気に入り
puts "Creating favorite items..."
FavoriteItem.create!(member: member1, item: shoes_item)
FavoriteItem.create!(member: member1, item: accessory_item)
FavoriteItem.create!(member: member2, item: womens_item2)

# 💰 購入履歴
puts "Creating purchases..."
purchase1 = Purchase.create!(
  member: member1,
  total_price: mens_item2.price + womens_item2.price
)

PurchaseItem.create!(
  purchase: purchase1,
  item: mens_item2,
  quantity: 1,
  subtotal: mens_item2.price
)

PurchaseItem.create!(
  purchase: purchase1,
  item: womens_item2,
  quantity: 1,
  subtotal: womens_item2.price
)

purchase2 = Purchase.create!(
  member: member2,
  total_price: accessory_item.price * 2
)

PurchaseItem.create!(
  purchase: purchase2,
  item: accessory_item,
  quantity: 2,
  subtotal: accessory_item.price * 2
)

# ⭐️ レビュー
puts "Creating reviews..."
Review.create!(
  member: member1,
  item: mens_item1,
  title: '着心地最高！',
  comment: '生地が柔らかく、着心地が抜群です。サイズ感も丁度良く、大満足です。',
  rating: 5
)

Review.create!(
  member: member1,
  item: womens_item2,
  title: '暖かくて使いやすい',
  comment: 'カシミヤの質が良く、暖かさと着心地が素晴らしいです。デザインもシンプルで合わせやすい。',
  rating: 4
)

Review.create!(
  member: member2,
  item: accessory_item,
  title: 'シンプルで上品',
  comment: 'デザインがシンプルで、普段使いにぴったりです。品質も良く、お手頃な価格で満足です。',
  rating: 5
)

puts "\n=== ✅ Seed data created successfully! ===\n"
puts "\n📊 Summary:"
puts "- Shop Categories: #{ShopCategory.count}"
puts "- Item Categories: #{ItemCategory.count}"
puts "- Shops: #{Shop.count}"
puts "- Items: #{Item.count}"
puts "- Members: #{Member.count}"
puts "- Owners: #{Owner.count}"
puts "- Reviews: #{Review.count}"
puts "- Purchases: #{Purchase.count}\n\n"
