class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:subject] = 'my_custom_from@domain.com'
    opts[:from] = 'my_custom_from@domain.com'
    opts[:reply_to] = 'my_custom_from@domain.com'
    super
  end
end