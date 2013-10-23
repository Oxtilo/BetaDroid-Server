BetaDroid::App.controllers :feed do
  before { @current_user = User.where(access_token: params[:token]).first }
  before { @current_release = Release.order("version_code DESC").first }

  get :index, map: "/feed/:token", provides: [:json] do
    content_type :json
    if @current_user && @current_user.accepted?
      if @current_release
        { 
          status: "NEW_RELEASE", 
          release: {
            name:         @current_release.name,
            version_code: @current_release.version_code,
            package:      @current_release.package,
            build_time:   @current_release.build_time,
            icon:         File.join(request.base_url, "icons/#{@current_release.id}.png"),
            apk:          File.join(request.base_url, url_for(:feed, :download, token: @current_user.access_token))
          }
        }.to_json
      else
        { status: "EMPTY_RELEASE" }.to_json
      end
    else
      { status: "ACCESS_DENIED" }.to_json
    end
  end

  get :download, map: "/download/:token" do
    if @current_user && @current_user.accepted? && @current_release
      send_file(@current_release.apk_path, disposition: 'attachment', filename: "release_#{@current_release.version_code}.apk")
    else
      response.status = 404
    end
  end
end
  