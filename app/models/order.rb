# == Schema Information
# Schema version: 20110404174106
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :text
#  email      :string(255)
#  pay_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order"]

  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
