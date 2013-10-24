BetaDroid::App.controllers :help do
  before { login_required! }
  before { set_tab :help }
  
  get :index do
    render "help/index"
  end
  

end
