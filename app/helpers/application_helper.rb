module ApplicationHelper

  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonyator (number, krokodil, krokodila, krokodilov, with_number = false)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    prefix = ''
    prefix = "#{number} " if with_number

    ostatok = number % 10
    ostatok100 = number % 100

    if ostatok100 >= 11 && ostatok100 <=14
      return "#{prefix}#{krokodilov}"
    elsif ostatok == 1
      return "#{prefix}#{krokodil}"
    elsif ostatok >= 2 && ostatok <= 4
      return "#{prefix}#{krokodila}"
    elsif ostatok > 4 || ostatok == 0
      return "#{prefix}#{krokodilov}"
    end
  end

end
