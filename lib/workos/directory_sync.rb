# frozen_string_literal: true
# typed: true

require 'net/http'

module WorkOS
  # The Directory Sync module provides convenience methods for working with the
  # WorkOS Directory Sync platform. You'll need a valid API key and to have
  # created a Directory Sync connection on your WorkOS dashboard.
  #
  # @see https://docs.workos.com/directory-sync/overview
  module DirectorySync
    class << self
      extend T::Sig
      include Base
      include Client

      # Retrieve directories.
      #
      # @param [Hash] options An options hash
      # @option options [String] domain The domain of the directory to be
      #  retrieved.
      # @option options [String] search A search term for direcory names.
      # @option options [String] limit Maximum number of records to return.
      # @option options [String] before Pagination cursor to receive records
      #  before a provided Directory ID.
      # @option options [String] after Pagination cursor to receive records
      #  before a provided Directory ID.
      #
      # @return [Hash]
      sig do
        params(
          options: T::Hash[Symbol, String],
        ).returns(WorkOS::Types::ListStruct)
      end
      def list_directories(options = {})
        response = execute_request(
          request: get_request(
            path: '/directories',
            auth: true,
            params: options,
          ),
        )

        parsed_response = JSON.parse(response.body)
        directories = parsed_response['data'].map do |directory|
          ::WorkOS::Directory.new(directory.to_json)
        end

        WorkOS::Types::ListStruct.new(
          data: directories,
          list_metadata: parsed_response['listMetadata'],
        )
      end

      # Retrieve directory groups.
      #
      # @param [Hash] options An options hash
      # @option options [String] directory The ID of the directory whose
      #  directory groups will be retrieved.
      # @option options [String] user The ID of the directory user whose
      #  directory groups will be retrieved.
      # @option options [String] limit Maximum number of records to return.
      # @option options [String] before Pagination cursor to receive records
      #  before a provided Directory Group ID.
      # @option options [String] after Pagination cursor to receive records
      #  before a provided Directory Group ID.
      #
      # @return [Hash]
      sig do
        params(
          options: T::Hash[Symbol, String],
        ).returns(WorkOS::Types::ListStruct)
      end
      def list_groups(options = {})
        response = execute_request(
          request: get_request(
            path: '/directory_groups',
            auth: true,
            params: options,
          ),
        )

        parsed_response = JSON.parse(response.body)
        groups = parsed_response['data'].map do |group|
          ::WorkOS::DirectoryGroup.new(group.to_json)
        end

        WorkOS::Types::ListStruct.new(
          data: groups,
          list_metadata: parsed_response['listMetadata'],
        )
      end

      # Retrieve directory users.
      #
      # @param [Hash] options An options hash
      # @option options [String] directory The ID of the directory whose
      #  directory users will be retrieved.
      # @option options [String] user The ID of the directory group whose
      #  directory users will be retrieved.
      # @option options [String] limit Maximum number of records to return.
      # @option options [String] before Pagination cursor to receive records
      #  before a provided Directory User ID.
      # @option options [String] after Pagination cursor to receive records
      #  before a provided Directory User ID.
      #
      # @return [Hash]
      sig do
        params(
          options: T::Hash[Symbol, String],
        ).returns(WorkOS::Types::ListStruct)
      end
      def list_users(options = {})
        response = execute_request(
          request: get_request(
            path: '/directory_users',
            auth: true,
            params: options,
          ),
        )

        parsed_response = JSON.parse(response.body)
        users = parsed_response['data'].map do |user|
          ::WorkOS::DirectoryUser.new(user.to_json)
        end

        WorkOS::Types::ListStruct.new(
          data: users,
          list_metadata: parsed_response['listMetadata'],
        )
      end

      # Retrieve the directory group with the given ID.
      #
      # @param [String] id The ID of the directory group.
      #
      # @return Hash
      sig { params(id: String).returns(T::Hash[String, T.untyped]) }
      def get_group(id)
        response = execute_request(
          request: get_request(
            path: "/directory_groups/#{id}",
            auth: true,
          ),
        )

        JSON.parse(response.body)
      end

      # Retrieve the directory user with the given ID.
      #
      # @param [String] id The ID of the directory user.
      #
      # @return Hash
      sig { params(id: String).returns(T::Hash[String, T.untyped]) }
      def get_user(id)
        response = execute_request(
          request: get_request(
            path: "/directory_users/#{id}",
            auth: true,
          ),
        )

        JSON.parse(response.body)
      end

      # Delete the directory with the given ID.
      #
      # @param [String] id The ID of the directory.
      #
      # @return Boolean
      sig { params(id: String).returns(T::Boolean) }
      def delete_directory(id)
        request = delete_request(
          auth: true,
          path: "/directories/#{id}",
        )

        response = execute_request(request: request)

        response.is_a? Net::HTTPSuccess
      end
    end
  end
end
