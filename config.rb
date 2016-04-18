require 'dotenv'
Dotenv.load

activate :es6

set :haml, { :ugly => true, :format => :html5 }

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :jasmine

sprockets.append_path File.join root, 'bower_components'

activate :directory_indexes

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip

  set :js_compressor, Uglifier.new(mangle: false)
end


activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['AWS_S3_BUCKET']
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.delete                     = false
  s3_sync.after_build                = false
  s3_sync.prefer_gzip                = true
  s3_sync.reduced_redundancy_storage = false
end

caching_policy 'text/css',               max_age: 315360000, must_revalidate: false
caching_policy 'application/javascript', max_age: 315360000, must_revalidate: false
caching_policy 'image/png',              max_age: 315360000, must_revalidate: false
