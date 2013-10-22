BetaDroid::App.controllers :releases do
  before { admin_required! }
  before { set_tab :releases }
  
  get :index do
    @releases = Release.order("version_code DESC").all

    render "releases/index"
  end

  get :upload do
    set_tab :upload
    render "releases/upload"
  end

  post :upload do
    set_tab :upload
    @release = Release.read(params[:apk])

    if @release.valid?
      redirect_to "/"
    else
      render "releases/upload"
    end
  end

end
