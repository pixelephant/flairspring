#encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "flairspring@flairspring.hu"

  def order_email(order)
    @order = order

    mail(:to => @order.user.email, :subject => "Megrendelés")
  end

  def order_status(order)
    @order = order

    mail(:to => @order.user.email, :subject => "Megrendelésének állapota változott")
  end
end
