class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

private

  def default_url_options
    {
      :host => 'localhost',
      :port => 3000,
      :scheme => :http
    }
  end

end
