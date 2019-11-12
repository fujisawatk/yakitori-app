module OmniauthMocks
  def twitter_mock
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      {
        "provider" => "twitter",
        "uid" => "0000000000000000000",
        "info" => {
          "name" => "twitter-user"
        },
        "credentials" => {
          "token" => "twitter-token-12345678",
          "secret" => "twitter-secret-12345678"
        },
      }
    )
  end

  def google_oauth2_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      {
        provider: "google_oauth2",
        uid: "100000000000000000000",
        info: {
          email: "google-email@example.com",
          name: "google-user"
        }
      }
    )
  end
end
