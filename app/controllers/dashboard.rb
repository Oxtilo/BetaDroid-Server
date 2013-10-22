BetaDroid::App.controllers :dashboard do
  before { login_required! }

  get :index, map: "/" do
    render "dashboard/index"
  end
end
