class History < ActiveRecord::Base
	validate :double_dates, on: :create
	validates_uniqueness_of :slot, if: Proc.new {|history| history.credit.blank?}, message: "Already created "
  before_create :calculate_balance
  class << self
  	def cash_deposited
  		where.not(credit: nil)
  	end
  end

  def calculate_balance
    last = History.last
    last_balance = last ? last.balance.to_i : 0
    self.balance = self.credit ? self.credit.to_i+last_balance : last_balance-self.debit.to_i    
  end
  
  private
  def double_dates  	
    if History.where("DATE(created_at) = ?", Date.today).length > 3
      errors.add(:created_at, "Already created morning entry")
    end
  end

end
