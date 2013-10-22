BetaDroid::App.controllers :dashboard do
  before { login_required! }
  before { set_tab :dashboard }

  get :index, map: "/" do
    render "dashboard/index"
  end

end
