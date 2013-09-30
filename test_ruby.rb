#require 'jruby'

begin
    #JRuby.parse(File.read("foo.rb"))
    puts "File name: #{__FILE__}"
rescue SyntaxError => e
    p 'NO file'
end
