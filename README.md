# Blog

Blog application powered by hanami, vue.js and hyperapp.

## Setup

```
From root path

# create .env.***
touch .env.development
vi .env.development

~~~ write those environment variable
DATABASE_URL="xxxxxxxxxxx"
SERVE_STATIC_ASSETS="xxxxxxxxxxx"
WEB_SESSIONS_SECRET="xxxxxxxxxxx"
ADMIN_SESSIONS_SECRET="xxxxxxxxxxx"
ADMIN_BASIC_AUTH_USER="xxxxxxxxxxx"
ADMIN_BASIC_AUTH_PASSWORD="xxxxxxxxxxx"
~~~

# bundle ruby gems
bundle install --path vendor/bundle

# bundle javascript node_modules
npm install

# migrate db
HANAMI_ENV=env bundle exec hanami db create
HANAMI_ENV=env bundle exec hanami db migrate

From root/bin/

# copy icons for markdown editor
sh init.sh
```