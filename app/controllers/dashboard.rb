BetaDroid::App.controllers :dashboard do
  before { login_required! }
  before { set_tab :dashboard }

  get :index, map: "/" do
    @current_release = Release.order("version_code DESC").first
    render "dashboard/index"
  end

end
    