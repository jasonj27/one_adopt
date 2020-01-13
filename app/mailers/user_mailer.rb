class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:subject] = '貓狗大平台帳號確認信'
    opts[:from] = 'One_adopt <postmaster@mg.oneadopt.today>'
    opts[:reply_to] = 'One_adopt'
    super
  end
end