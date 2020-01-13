class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:subject] = '貓狗大平台帳號確認信'
    opts[:from] = 'one_adopt'
    opts[:reply_to] = 'one_adopt'
    super
  end
end