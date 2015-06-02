# adapted from this URL: https://github.com/google/google-api-ruby-client-samples

class UserGoogleSessionsController < ApplicationController

  before_action :require_logout, :only => [:new, :create]

  def new
    redirect_to auth_client.authorization.authorization_uri.to_s
  end

  def create
    @profile = with_auth_client do |client|
      client.authorization.code = params[:code]
      client.authorization.update!
      tokens = client.authorization.fetch_access_token
      client.authorization.access_token = tokens['access_token']
      client.authorization.id_token = tokens['id_token']
      raise 'Invalid Email' unless client.authorization.decoded_id_token['email_verified']
      plus = client.discovered_api('plus', 'v1')
      JSON.parse client.execute!(plus.people.get, :collection => 'visible', :userId => 'me').body
    end rescue nil
    if @profile
      email = @profile['emails'].detect { |e| e['type'] == 'account' }['value']
      @user = User.where(:email => email).first || User.new(:email => email, :uses_oauth => true)
      @user.first_name = @profile['name']['givenName']
      @user.last_name = @profile['name']['familyName']
      @user.save!
      @user_session = UserSession.create!(@user, true) if @user
    end
    redirect_to root_path
  end

private

  def with_auth_client(&block)
    block.call auth_client
  end

  def auth_client
    c = Google::APIClient.new(
      :application_name => 'webdevfinal',
      :application_version => '1.0.0',
      :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
      :audience => 'https://accounts.google.com/o/oauth2/token',
      :scope => [ 'profile', 'email' ]
    )
    c.authorization.grant_type = 'authorization_code'
    c.authorization.client_id = "1068055082975-pindla6dir92jtna3jj9bfvrf47loe61.apps.googleusercontent.com"
    c.authorization.client_secret = "7jAMkdRBE5abjBOru8FGFa5u"
    c.authorization.redirect_uri = google_authenticate_url
    c.authorization.additional_parameters = { :approval_prompt => 'force', :access_type => 'online' }
    c.authorization.scope = [ 'profile', 'email' ]
    c
  end

end