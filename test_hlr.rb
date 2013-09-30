# HLR connection test
require 'net/telnet'


@hlr = Net::Telnet::new("Host" => "10.10.10.63",
                        #"Telnetmode" => false,
                        "Port" => "7776",
                        #"Prompt" => "/./",
                        #"Timeout" => 30
                        )

@hlr = Net::Telnet::new("Host" => "10.10.10.63", "Port" => "7776" )

command_login = 'LGI: HLRSN=1, OPNAME="mtmaccess", PWD="mtmaccess321";'

command_get_isdn = 'LST IMSI: ISDN="94783591264";'

# @hlr.cmd("String" => command, "Match" => "/(END)/") do |out|
#         puts out
# end

# command2 = 'LST ISDN: IMSI="358252046579103";'

# @hlr.cmd("String" => command2, "Match" => "/(END)/") do |out|
#         puts out
# end

#lines_to_send = ['LGI: HLRSN=1, OPNAME="mtmaccess", PWD="mtmaccess321";', 'LST ISDN: IMSI="358252046579103";']

#lines_to_send.each do |line|
#  @hlr.puts(line)
#
#  @hlr.waitfor(/./) do |data|
#    puts data
#  end
#end

# @ISDN = "94783591264"

# command3 = "LST IMSI: ISDN=\"#{@ISDN}\";"

@hlr.puts(command_login)

@hlr.waitfor(/(END)/) do |data|
    puts data
end

@hlr.puts(command_get_isdn)

@hlr.waitfor(/(END)/) do |data|
    puts data
end

def login

end


