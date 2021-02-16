class OrderInformation
  include ActiveModel::Model
  attr_accessor :post_code,:region_id,:city,:address,:building,:phone_number,:item_id,:user_id,:token

  POST_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  PHONE_NUMBER_REGEX = /\A\d{1,11}\z/
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :token
    validates :post_code,format: {with:POST_CODE_REGEX,message: 'Input correctly'}
    validates :city
    validates :address
    validates :phone_number,format: {with:PHONE_NUMBER_REGEX,message: 'Input only number'}
    validates :region_id,numericality: { other_than: 1, message: 'Select' }
    validates :item_id
    validates :user_id
  end

  def save 
    order = Order.create(user_id:user_id, item_id:item_id)
    DeliveryLocation.create(post_code: post_code,region_id: region_id,city:city,address:address,building:building,phone_number:phone_number,order_id:order.id)
  end
end