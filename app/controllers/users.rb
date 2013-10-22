BetaDroid::App.controllers :users do
  before { set_tab :users }
  before { admin_required! }

  get :index do
    @users = User.order("active ASC, name ASC").all
    render "users/index"
  end

  get :accept do
    @user = User.find(params[:id])
    @user.active = true
    @user.save
  end

  get :cancel do
    @user = User.find(params[:id])
    @user.active = false
    @user.save
  end

end
