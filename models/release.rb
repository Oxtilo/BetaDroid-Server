class Release < ActiveRecord::Base
  serialize :permissions

  validates :name, :build_time, :version_name, :version_code, :package, :size, presence: true
  validates :version_code, uniqueness: true

  
  
  def self.read(file)
    release               = Release.new

    begin
      file                  = file[:tempfile] if file
      apk                   = Android::Apk.new(file ? file.path : "")
      release.build_time    = apk.time
      release.name          = apk.manifest.label
      release.version_name  = apk.manifest.version_name
      release.version_code  = apk.manifest.version_code
      release.package       = apk.manifest.package_name
      release.permissions   = apk.manifest.use_permissions
      release.size          = apk.size
    rescue Android::NotApkFileError => e
    rescue Android::NotFoundError => e
    end
    if release.save
      releases_path     = File.join(Padrino.root, "releases/")
      icons_public_path = File.join(Padrino.root, "public/icons/")
      FileUtils.mkdir_p(releases_path)
      FileUtils.mkdir_p(icons_public_path)
      FileUtils.cp(file.path, File.join(release.apk_path))

      icon_key = apk.icon.keys.last
      data     = apk.icon[icon_key]
      File.open(File.join(icons_public_path, "#{release.id}.png"), 'wb') { |f| f.write data }
    end

    release
  end

  def apk
    Android::Apk.new(apk_path)
  end

  def apk_path
    File.join(Padrino.root, "releases/#{self.id}.apk")
  end

end
