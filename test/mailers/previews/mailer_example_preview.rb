# Preview all emails at http://localhost:3000/rails/mailers/mailer_example
class MailerExamplePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer_example/textAction
  def textAction
    MailerExample.textAction
  end

end
