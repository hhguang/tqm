Rails.application.config.middleware.use OmniAuth::Builder do
	OmniAuth.config.on_failure = Proc.new { |env|
	  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
	}
  provider :identity, :fields => [:name, :email]
end