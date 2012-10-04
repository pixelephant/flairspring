class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :addresses_attributes, :first_name, :last_name, :title_name, :phone
	has_many :addresses
	has_many :orders
	has_one :wishlist

	accepts_nested_attributes_for :addresses

  after_create :send_reg_email

  def order_sum
    sum = 0
    self.orders.each do |order|
      order.order_items.each do |item|
        sum = sum + (item.quantity * item.price)
      end
    end

    return sum
  end

  def personal_discount_used
    if self.orders.any?
      sum = 0
      self.orders.each do |order|
        sum = sum + order.discount_used.to_i
      end
    else
      return 0
    end
    return sum
  end

  def personal_discount_available
    if self.orders.any?
      sum = 0
      self.orders.each do |order|
        sum = sum + (order.price.to_i * PERSONAL_DISCOUNT) - order.discount_used.to_i
      end
    else
      return 0
    end
    return sum
  end

  def send_reg_email
    UserMailer.reg_email(self).deliver    
  end

end