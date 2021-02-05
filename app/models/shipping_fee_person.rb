class ShippingFeePerson < ActiveHash::Base
  self.data = [
    { id: 1, pay: '---' },
    { id: 2, pay: '着払い(購入者負担)' },
    { id: 3, pay: '送料込み(出品者負担)' }
  ]

  include ActiveHash::Associations
  has_many :items
end
