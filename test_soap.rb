# require 'savon'
# require "base64"
# require 'digest/sha1'

# @username = "MTM_ADMIN"
# @password = 'jD37$nd4uq'
# @nonce = Random.new_seed.to_s[0..9]
# @encoded_nonce = Base64.encode64([@nonce].pack("H*")).chomp!

# @timestamp = Time.now.utc.xmlschema
# # An alternative method to create UTC time stamp
# #@timestamp = Time.new.strftime("%Y-%m-%d\T%H:%M:%S\Z")
# @password_digest = Base64.encode64(Digest::SHA1.digest([@nonce].pack("H*") + [@timestamp].pack("a*") + [@password].pack("a*"))).chomp!

# @header ="<wsse:Security SOAP-ENV:mustUnderstand=\"1\" xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">
#             <wsse:UsernameToken>
#               <wsse:Username>#{@username}</wsse:Username>
#               <wsse:Password Type=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest\">#{@password_digest}</wsse:Password>
#               <wsse:Nonce>#{@encoded_nonce}</wsse:Nonce>
#               <wsu:Created xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\">#{@timestamp}</wsu:Created>
#             </wsse:UsernameToken>
#           </wsse:Security>"


# client = Savon.client do |globals|
#         globals.wsdl "http://192.9.202.26/ccws/ccws.asmx?wsdl"
#         globals.soap_header @header
#         globals.env_namespace 'SOAP-ENV'
#         globals.namespace_identifier 'ns'
# end


# res = client.call(:get_cache)

# p res

# require "ccws_soap_connector"

# con = CcwsSoapConnector.new

# puts con.header

# res = con.client.call(:get_version_id)

# puts res

# # Retrieve_Subscriber_With_Identity_With_History_For_Multiple_Identities

# message = {
#   subscriber_id: '0787423363',
#   identity:'NULL',
#   information_to_retrieve: '(1+1024+256)',
#   start_date:'2013-09-02',
#   end_date:'2013-09-04',
#   is_all_identity: false
# }
# res = con.client.call(:retrieve_subscriber_with_identity_with_history_for_multiple_identities, message: message)

require "ccws_soap_client"

client = CcwsSoapClient.new

client.username = 'MTM_ADMIN'
client.password = 'jD37$nd4uq'

CcwsSoapClient.global :soap_header, client.header

client.call(:get_version_id)
