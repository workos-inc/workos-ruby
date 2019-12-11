# typed: true
# frozen_string_literal: true

require 'rack/utils'
require 'net/http'
require 'uri'
require 'json'

module WorkOS
  # The SSO module provides convenience methods for working with the WorkOS
  # SSO service. You'll need a valid API key, a project ID, and to have
  # created an SSO connection on your WorkOS dashboard.
  #
  # @see https://dashboard.workos.com/docs/sso/what-is-sso
  module SSO
    extend T::Sig

    sig do
      params(
        domain: String,
        project_id: String,
        redirect_uri: String,
        state: Hash,
      ).returns(String)
    end

    # Generate an Oauth2 authorization URL where your users will
    # authenticate using the configured SSO Identity Provider.
    #
    # @param [String] domain The domain for the relevant SSO Connection
    #  configured on your WorkOS dashboard
    # @param [String] project_id The WorkOS project ID for the project
    #  where you've  configured your SSO connection
    # @param [String] redirect_uri The URI where users are directed 
    #  after completing the authentication step. Must match a
    #  configured redirect URI on your WorkOS dashboard
    # @param [Hash] state An aribtrary state object 
    #  that is preserved and available to the client in the response.
    # @example
    #   WorkOS::SSO.authorization_url(
    #     domain: 'acme.com',
    #     project_id: 'project_01DG5TGK363GRVXP3ZS40WNGEZ',
    #     redirect_uri: 'https://workos.com/callback',
    #     state: { 
    #       next_page: '/docs'
    #     }
    #   )
    #   => "https://api.workos.com/sso/authorize?domain=acme.com" \
    #      "&client_id=project_01DG5TGK363GRVXP3ZS40WNGEZ" \
    #      "&redirect_uri=https%3A%2F%2Fworkos.com%2Fcallback&" \
    #      "response_type=code&state=%7B%3Anext_page%3D%3E%22%2Fdocs%22%7D"
    # @return [String]
    def self.authorization_url(domain:, project_id:, redirect_uri:, state: {})
      query = Rack::Utils.build_query(
        domain: domain,
        client_id: project_id,
        redirect_uri: redirect_uri,
        response_type: 'code',
        state: state,
      )

      "https://#{WorkOS::API_HOSTNAME}/sso/authorize?#{query}"
    end

    sig do
      params(
        code: String,
        project_id: String,
        redirect_uri: String,
      ).returns(TrueClass)
    end
    # WorkOS::SSO.profile(code: 'foo', project_id: 'project_01DG5TGK363GRVXP3ZS40WNGEZ', redirect_uri: 'https://zach.workos.dev/callback')
    # Fetch the profile details for the authenticated SSO user.
    #
    # @param [String] code The authorization code provided in the callback URL
    # @param [String] project_id The WorkOS project ID for the project
    #  where you've  configured your SSO connection
    # @param [String] redirect_uri The URI where the user was directed 
    #  after completing the authentication step.
    #
    # @example
    #   WorkOS::SSO.profile(
    #     code: 'acme.com',
    #     project_id: 'project_01DG5TGK363GRVXP3ZS40WNGEZ',
    #     redirect_uri: 'https://workos.com/callback',
    #   )
    #   => "https://api.workos.com/sso/authorize?domain=acme.com" \
    #      "&client_id=project_01DG5TGK363GRVXP3ZS40WNGEZ" \
    #      "&redirect_uri=https%3A%2F%2Fworkos.com%2Fcallback&" \
    #      "response_type=code&state=%7B%3Anext_page%3D%3E%22%2Fdocs%22%7D"
    # @return [String]
    def self.profile(code:, project_id:, redirect_uri:)
      res = Net::HTTP.post_form(
        URI("https://#{WorkOS::API_HOSTNAME}/sso/token"),
        client_id: project_id,
        client_secret: WorkOS.key!,
        redirect_uri: redirect_uri,
        grant_type: 'authorization_code',
        code: code,
      )

      puts res

      true
    end
  end
end
