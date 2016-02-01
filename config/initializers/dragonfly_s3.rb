require 'dragonfly/s3_data_store'

if Rails.env.development?
  bucket_name = "mpasummercampcodesdev"
else
  bucket_name = "mpasummercampcodes"
end

Dragonfly.app.configure do
  datastore :s3,
    bucket_name: bucket_name,
    access_key_id: ENV['S3_CAMPS_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_CAMPS_SECRET_ACCESS_KEY']
end
