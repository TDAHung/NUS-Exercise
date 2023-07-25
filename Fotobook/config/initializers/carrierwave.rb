CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIATR2UNP75OKPZ7H5O',                        # required unless using use_iam_profile
    aws_secret_access_key: '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',                        # required unless using use_iam_profile
    # use_iam_profile:       true,                         # optional, defaults to false
    region:                'ap-southeast-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'rails-test-tdahung'                                      # required
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
