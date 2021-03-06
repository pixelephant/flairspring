#encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "flairspring@flairspring.hu"

  def order_email(order)
    @order = order

    mail(:to => @order.email, :subject => "Megrendelés")
  end

  def order_status(order)
    @order = order

    mail(:to => @order.email, :subject => "Megrendelésének állapota változott")
  end

  def reg_email(user)
  	@user = user

  	mail(:to => @user.email, :subject => "Köszönjük regisztrációját")
  end
end
