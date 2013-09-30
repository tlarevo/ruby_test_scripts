### CCWS SOAP client ###

require 'savon'
require 'digest/sha1'
require 'base64'

class CcwsSoapClient
  extend Savon::Model

  client wsdl: "http://192.9.202.26/ccws/ccws.asmx?wsdl"

  global :env_namespace, 'SOAP-ENV'
  global :namespace_identifier, 'ns'

  def username=(username)
    @username = username
  end

  def username
    @username
  end

  def password=(password)
    @password = password
  end

  def password
    @password
  end

  def nonce
    @nonce ||= Random.new_seed.to_s[0..9]
  end

  def encoded_nonce
    Base64.encode64([nonce].pack("H*")).chomp!
  end

  def timestamp
    @timestamp ||= Time.now.utc.xmlschema
  end

  def token
    @token ||= Digest::SHA1.digest([nonce].pack("H*") + [timestamp].pack("a*") + [password].pack("a*"))
  end

  def digest
    @digest ||= Base64.encode64(token).chomp!
  end

  def header=(header)
    @header = header
  end

  def header
    @header ||="<wsse:Security SOAP-ENV:mustUnderstand=\"1\" xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">
                  <wsse:UsernameToken>
                    <wsse:Username>#{username}</wsse:Username>
                    <wsse:Password Type=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest\">#{digest}</wsse:Password>
                    <wsse:Nonce>#{encoded_nonce}</wsse:Nonce>
                    <wsu:Created xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\">#{timestamp}</wsu:Created>
                  </wsse:UsernameToken>
                </wsse:Security>"
  end

end
