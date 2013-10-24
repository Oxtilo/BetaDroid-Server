module BetaDroid
  class App < Padrino::Application
    API_VERSION = 1
    #use Rack::Session::Cookie
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Cache
    
    enable :sessions
    disable :caching

    before { expires_in 1 }


    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end
    
    def set_tab(name)
      @current_tab = name.to_sym
    end

    def current_user
      @current_user ||= User.where(id: session[:user_id]).first
    end

    def logged_in?
      !current_user.nil?
    end

    def admin?
      logged_in? && current_user.admin?
    end

    def admin_required!
      redirect_to "/" unless admin?
    end

    def login_required!
      redirect_to "/auth" unless logged_in?
    end

    ["GOOGLE_KEY", "GOOGLE_SECRET", "ADMIN_EMAIL"].each do |key|
      throw "#{key} is empty set it in .env file" if ENV[key] == nil
    end

    use OmniAuth::Builder do
      provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
    end
  end
end