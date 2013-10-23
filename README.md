BetaDroid Server
================

![Web](https://raw.github.com/Oxtilo/BetaDroid-Server/master/doc/web.png)

Painless over-the-air app distribution to your testers web backend.

[
  ![Android app on Google Play](https://developer.android.com/images/brand/en_app_rgb_wo_45.png)
](https://play.google.com/store/apps/details?id=developer.macbury.betadroid ) or https://github.com/Oxtilo/BetaDroid-Android

Setup
================
Install ruby 1.9.3 on your system and clone application:
```
git clone git@github.com:Oxtilo/BetaDroid-Server.git
cd BetaDroid-Server
```
Create config file .env with content:
```
GOOGLE_KEY=google-oauth-key-here
GOOGLE_SECRET=google-oauth-secret-here
ADMIN_EMAIL=admin@email.here
APP_NAME=app-name-to-display
APP_DESCRIPTION=short-app-description
```

Create credentials in https://code.google.com/apis/console/ for oauth google plus login and place it in .env file for key GOOGLE_KEY and GOOGLE_SECRET. Callback url will be pointing to /auth/google_oauth2/callback path.

Install dependencies and create sqlite3 db
```
bundle install
bundle exec padrino rake ar:create -e production
bundle exec padrino rake ar:migrate -e production
```

And finally run webserver
```
bundle exec padrino start -h 0.0.0.0 -p 80 -e production
```
