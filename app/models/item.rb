class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :delivery_day, :ship_from_region, :shipping_fee_person

  with_options presence: true do
    validates :image, :name, :description
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id, :condition_id, :ship_from_region_id, :shipping_fee_person_id, :delivery_day_id
    end
  end

  validate :price_half_width_valid

  def price_half_width_valid
    errors.add(:price, 'Half-width number') if price_before_type_cast.to_s !~ /\A[0-9]+\z/
  end
end
