class Item < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :client_id
  belongs_to :client
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

end
