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
Item.delete_all
ShopCategoryAssignment.delete_all
Shop.delete_all
ShopCategory.delete_all
Owner.delete_all
Member.delete_all

# 👤 オーナー作成
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
ShopCategory.all_categories.each(&:save!)

# 🏬 ショップ作成
mens_shop = Shop.create!(
  owner: owner1,
  name: 'メンズスタイル東京',
  description: '上質な素材とモダンなデザインにこだわった、大人のためのメンズファッションを提供。トレンドと品質を両立させた商品を取り揃え、お客様のスタイリッシュな装いをサポートします。',
  shop_categories: [ShopCategory.find_by_id(ShopCategory::MENS_FASHION)]
)

womens_shop = Shop.create!(
  owner: owner1,
  name: 'レディースコレクション',
  description: '女性の毎日を彩るトレンド感のある商品をセレクト。カジュアルからフォーマルまで、様々なシーンに対応したアイテムを提供し、お客様の個性的なスタイリングをお手伝いします。',
  shop_categories: [ShopCategory.find_by_id(ShopCategory::WOMENS_FASHION)]
)

accessory_shop = Shop.create!(
  owner: owner2,
  name: 'アクセサリーワールド',
  description: 'トレンディで洗練されたアクセサリーを豊富に取り揃えています。シンプルな普段使いのアイテムから、特別な日のための華やかなピースまで、幅広いコレクションをご用意。',
  shop_categories: [
    ShopCategory.find_by_id(ShopCategory::ACCESSORIES),
    ShopCategory.find_by_id(ShopCategory::BAGS)
  ]
)

sports_shop = Shop.create!(
  owner: owner2,
  name: 'スポーツライフ',
  description: 'アクティブなライフスタイルを応援するスポーツ用品店。最新のトレーニングウェアからプロ仕様の本格的な用具まで、幅広い商品を取り扱っています。',
  shop_categories: [
    ShopCategory.find_by_id(ShopCategory::SPORTS),
    ShopCategory.find_by_id(ShopCategory::OUTDOOR)
  ]
)

beauty_shop = Shop.create!(
  owner: owner2,
  name: 'ビューティーハウス',
  description: '自然由来の原料にこだわったコスメや、オーガニックスキンケア製品を中心に取り扱うビューティーショップ。お客様の美しさと健康をトータルでサポートします。',
  shop_categories: [
    ShopCategory.find_by_id(ShopCategory::BEAUTY),
    ShopCategory.find_by_id(ShopCategory::HEALTH)
  ]
)

# 👕 商品作成
mens_item1 = Item.create!(
  shop: mens_shop,
  name: 'クラシックTシャツ',
  description: '上質な綿100%を使用したベーシックなTシャツ',
  price: 3900,
  stock: 50
)

mens_item2 = Item.create!(
  shop: mens_shop,
  name: 'スリムフィットジーンズ',
  description: '履き心地抜群のストレッチデニム',
  price: 8900,
  stock: 30
)

womens_item1 = Item.create!(
  shop: womens_shop,
  name: 'フラワーワンピース',
  description: '春にぴったりの花柄ワンピース',
  price: 12900,
  stock: 20
)

womens_item2 = Item.create!(
  shop: womens_shop,
  name: 'ニットカーディガン',
  description: '着回しやすい定番カーディガン',
  price: 7900,
  stock: 25
)

accessory_item = Item.create!(
  shop: accessory_shop,
  name: 'シルバーネックレス',
  description: 'シンプルで上品なデザインのネックレス',
  price: 5900,
  stock: 15
)

shoes_item = Item.create!(
  shop: mens_shop,
  name: 'レザースニーカー',
  description: '上質な本革を使用したスニーカー',
  price: 15900,
  stock: 10
)

# 📢 お知らせ
ReleaseInfo.create!(
  shop: mens_shop,
  title: '2024年春夏コレクション入荷',
  body: '待望の春夏コレクションが入荷しました。最新トレンドのアイテムを多数取り揃えております。',
  status: 1
)

ReleaseInfo.create!(
  shop: womens_shop,
  title: '送料無料キャンペーン実施中',
  body: '期間限定で1万円以上のお買い物が送料無料になります。この機会にぜひご利用ください。',
  status: 1
)

ReleaseInfo.create!(
  shop: beauty_shop,
  title: '新商品入荷のお知らせ',
  body: '人気のオーガニックスキンケアシリーズに、新商品が仲間入りしました。',
  status: 1
)

# 🛒 カート
cart1 = Cart.create!(member: member1)
CartItem.create!(cart: cart1, item: mens_item1, quantity: 1)
CartItem.create!(cart: cart1, item: womens_item1, quantity: 1)

cart2 = Cart.create!(member: member2)
CartItem.create!(cart: cart2, item: accessory_item, quantity: 2)

# ❤️ お気に入り
FavoriteItem.create!(member: member1, item: shoes_item)
FavoriteItem.create!(member: member1, item: accessory_item)
FavoriteItem.create!(member: member2, item: womens_item2)

# 💰 購入履歴
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
puts "- Categories: #{ShopCategory.count}"
puts "- Shops: #{Shop.count}"
puts "- Items: #{Item.count}"
puts "- Members: #{Member.count}"
puts "- Owners: #{Owner.count}"
puts "- Reviews: #{Review.count}"
puts "- Purchases: #{Purchase.count}\n\n"
