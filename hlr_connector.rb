#### This is the hlr connector class ####

require 'net/telnet'

class HLRConnector

  @@config = {
    "Host" => "10.10.10.63",
    "Port" => "7776"
  }

  @@credentials = {
    username: "mtmaccess",
    password: "mtmaccess321"
  }

  # Initializer for the HLRConnector
  def initialize(config = @config)

    @hlr = Net::Telnet::new(config)

  end
  # Send commands to HLR
  def send_command(command)

    begin
      @hlr.puts(command)

      @hlr.waitfor(/(END)/) do  |result|
        return process_result_message(result)
      end
    rescue => e
        puts "Error occured: #{e.message}"
    end

  end

  # Process the received result message
  def process_result_message(result)

    @result_message = ""

    begin
      result.each_line do |line|
        if line[/(RETCODE)/] then
          puts line
          @result_message = line
          if line[/(\d+)/] then
            @result_code = line[/(\d+)/].to_i
            break
          else
            @result_code = nil
          end
        end
      end

      if @result_message.empty? or @result_code.nil? then
        @result_message = 'Invalid response from HLR'
      end
    rescue => e
      puts "Error occured: #{e.message}"
    end

    return evaluate_result_code
  end

  # Evalute the result code
  def evaluate_result_code
    begin
      if @result_code.zero? then
          puts "Command successful: #{@result_message}"
          return true
      else
          puts "Error occured: #{@result_message}"
          return false
      end
    rescue => e
      puts "Fatal Error: #{e.message}"
      logout
      return nil
    end
  end

  # Specialized method for login
  def login(username = @@credentials[:username], password = @@credentials[:password])

    command = "LGI: HLRSN=1, OPNAME=\"#{username}\", PWD=\"#{password}\";"
    response = send_command(command)

    if response then
        @connected = true
    else
        @connected = false
    end

    return response

  end

  # Change the apn when provided with the msidn and the apn category
  def change_apn(msisdn, category)

    case category
    when 'bypass' then tplid = 17
    when 'default' then tplid = 7
    else tplid = 7
    end

    if msisdn and category then
      if @connected then
        command = "MOD TPLGPRS: ISDN=\"#{msisdn}\", PROV=TRUE, TPLID=#{tplid};"
        response = send_command(command)
        return response
      else
        puts "Not connected to HLR"
      end
    else
      puts "Required data not provided, please provide msisdn and category"
    end

  end

  # Get the response code for the current MML command
  def get_response_code
    @result_code
  end

  # Get the response message for the current MML command
  def get_response_message
    @result_message
  end

  # Terminate the telnet session
  def logout
    @hlr.close
  end

end
