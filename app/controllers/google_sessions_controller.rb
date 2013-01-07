class GoogleSessionsController < ApplicationController

  def login
    auth = request.env['omniauth.auth']

    user = User.find_by_email(auth.info['email']) || User.new

    user.google_id    = auth['uid']
    user.email        = auth.info['email']
    user.first_name   = user.name = auth.info['first_name']
    user.last_name    = auth.info['last_name']
    user.google_image_url = auth.info['image']
    user.google_hd    = auth.extra.raw_info['hd']
    user.google_token = auth.credentials['token']

    # going away soon
    user.password = 'blablabla'
    user.password_confirmation = 'blablabla'

    user.save!

    sign_in user

    redirect_to request.env['omniauth.origin'] || root_url
  end

  def error
    flash[:error] =  "Sorry, something went wrong with the login."
    redirect_to request.env['omniauth.origin'] || root_url
  end
end
