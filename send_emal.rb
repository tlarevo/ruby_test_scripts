#!/usr/bin/env ruby -wKU

require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <me@fromdomain.com>
To: A Test User <tharindu.abeydeera@gmail.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
      smtp.send_message message, 'me@fromdomain.com', 'tharindu.abeydeera@gmail.com'
end

=begin
    This is multiline comment for ruby. very nice
=end
