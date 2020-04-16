require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      :provider => "AWS",
      :aws_access_key_id => BUCKETEER_AWS_ACCESS_KEY_ID,
      :aws_secret_access_key => BUCKETEER_AWS_SECRET_ACCESS_KEY,
      :region => "us-east-1"
    }
    config.fog_directory = BUCKETEER_BUCKET_NAME
    config.storage = :fog
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end