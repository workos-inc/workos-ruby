# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/rack/all/rack.rbi
#
# rack-1.6.11
module Rack
end
module Rack::Multipart
  def self.build_multipart(params, first = nil); end
  def self.parse_multipart(env); end
end
module Rack::Utils
  def best_q_match(q_value_header, available_mimes); end
  def build_nested_query(value, prefix = nil); end
  def build_query(params); end
  def byte_ranges(env, size); end
  def bytesize(string); end
  def clean_path_info(path_info); end
  def delete_cookie_header!(header, key, value = nil); end
  def escape(s); end
  def escape_html(string); end
  def escape_path(s); end
  def normalize_params(params, name, v = nil, depth = nil); end
  def params_hash_type?(obj); end
  def parse_nested_query(qs, d = nil); end
  def parse_query(qs, d = nil, &unescaper); end
  def q_values(q_value_header); end
  def rfc2109(time); end
  def rfc2822(time); end
  def secure_compare(a, b); end
  def select_best_encoding(available_encodings, accept_encoding); end
  def self.best_q_match(q_value_header, available_mimes); end
  def self.build_nested_query(value, prefix = nil); end
  def self.build_query(params); end
  def self.byte_ranges(env, size); end
  def self.bytesize(string); end
  def self.clean_path_info(path_info); end
  def self.delete_cookie_header!(header, key, value = nil); end
  def self.escape(s); end
  def self.escape_html(string); end
  def self.escape_path(s); end
  def self.key_space_limit; end
  def self.key_space_limit=(arg0); end
  def self.multipart_part_limit; end
  def self.multipart_part_limit=(arg0); end
  def self.normalize_params(params, name, v = nil, depth = nil); end
  def self.param_depth_limit; end
  def self.param_depth_limit=(arg0); end
  def self.params_hash_type?(obj); end
  def self.parse_nested_query(qs, d = nil); end
  def self.parse_query(qs, d = nil, &unescaper); end
  def self.q_values(q_value_header); end
  def self.rfc2109(time); end
  def self.rfc2822(time); end
  def self.secure_compare(a, b); end
  def self.select_best_encoding(available_encodings, accept_encoding); end
  def self.set_cookie_header!(header, key, value); end
  def self.status_code(status); end
  def self.unescape(s, encoding = nil); end
  def set_cookie_header!(header, key, value); end
  def status_code(status); end
  def unescape(s, encoding = nil); end
end
class Rack::Utils::ParameterTypeError < TypeError
end
class Rack::Utils::InvalidParameterError < ArgumentError
end
class Rack::Utils::Context
  def app; end
  def call(env); end
  def context(env, app = nil); end
  def for; end
  def initialize(app_f, app_r); end
  def recontext(app); end
end
class Rack::Utils::HeaderHash < Hash
  def [](k); end
  def []=(k, v); end
  def delete(k); end
  def each; end
  def has_key?(k); end
  def include?(k); end
  def initialize(hash = nil); end
  def key?(k); end
  def member?(k); end
  def merge!(other); end
  def merge(other); end
  def replace(other); end
  def self.new(hash = nil); end
  def to_hash; end
end
class Rack::Utils::KeySpaceConstrainedParams
  def [](key); end
  def []=(key, value); end
  def initialize(limit = nil); end
  def key?(key); end
  def to_params_hash; end
end
module WorkOS
end
module WorkOS::SSO
  def self.authorization_url(*args, &blk); end
  def self.profile(*args, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
