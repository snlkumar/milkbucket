class Item < ActiveRecord::Base
  belongs_to :client
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
end
