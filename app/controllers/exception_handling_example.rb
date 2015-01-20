# This controller's job is to exchange twitter credentials for Shortmail credentials
class TwitterReverseAuthController < ApplicationController
  # First, let's make our own subclass of RuntimeError
  class Error < RuntimeError; end

  def api_key_exchange
    # Here are our required parameters. If any are missing we raise an error
    screen_name = params.fetch(:screen_name) { raise Error.new('screen_name required')  }
    token =       params.fetch(:oauth_token) { raise Error.new('oauth_token required')  }
    secret =      params.fetch(:oauth_secret){ raise Error.new('oauth_secret required') }

    # OK now let's authenticate that user. If we can't find a valid user, raise an error
    @user = User.by_screen_name(screen_name).where(
      :oauth_token => token,
      :oauth_secret => secret
    ).first or raise Error.new('user not found')

    # Now we'll build a device. I'm not catching an exception on create! here because
    # It should never fail. (I.e. a failure is actually a 500 because we don't expect it)
    @device = Device.find_or_create_by_token!(
      params.slice(:token, :description).merge(:user_id => @user.id)
    )

    render :json => { :api_key => @device.api_key }

    # Now I can simply catch any of my custom exceptions here
    rescue Error => e
    # And render their message back to the user
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  #handle exception from all action
    rescue_from ActiveRecord::RecordNotFound, :with => :show_not_found
    rescue_from ActiveRecord::RecordInvalid, :with => :show_error

    protected

    def show_not_found
        # render something
    end

    def show_error
        # render something
    end
end
