BetaDroid::App.controllers :auth do

  get :index do
    render "auth/index"
  end

  get :google_callback, :map => "/auth/google_oauth2/callback" do
    omniauth = request.env["omniauth.auth"]
    @user    = User.where(uid: omniauth["uid"]).first
    @user    = User.new_from_omniauth(omniauth) if @user.nil?
    session[:user_id] = @user.id

    redirect_to("/")
  end

  get :logout do
    session[:user_id] = nil
    redirect_to("/")
  end
end
