class History < ActiveRecord::Base
	validate :double_dates, on: :create
	# validates_uniqueness_of :slot, if: Proc.new {|history| history.credit.blank?}, message: "Already created "
  before_create :calculate_balance
  after_destroy :change_balance
  class << self
  	def cash_deposited
  		where.not(credit: nil)
  	end
  end

  def calculate_balance    
    last = History.last
    last_balance = last ? last.balance.to_d : "0.0".to_d
    balance = self.credit ? ((self.credit.to_d)+last_balance) : (last_balance - self.debit.to_d)
    self.balance = to_amount(balance)
  end
  
  private
  def double_dates  	
    if History.where("DATE(created_at) = ?", Date.today).length > 3
      errors.add(:created_at, "Already created morning entry")
    end
  end

  def change_balance
    # last =  History.last
    # if last
    #   balance = last.balance.to_d
    #   if self.debit
    #     balance = balance + self.debit.to_d
    #   else
    #     balance = balance-self.credit.to_d
    #   end
    #   History.update(last.id, balance: to_amount(balance))
    # end
  end

  def to_amount(input)
    "%.2f" % input
  end

end
