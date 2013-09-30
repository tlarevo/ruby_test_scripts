require 'java'

# This require doesn't load the jdbc driver jar into the system class path
# require "c:/ruby/jruby-1.2.0/lib/ojdbc14.jar"
# require '/home/tharindu/jruby/jruby-1.7.4/lib/ojdbc6.jar'

# 2 ways you can load the class (There are probably more)

# 1 ruby syntax for java class name
Java::OracleJdbcDriver::OracleDriver

# 2 Use the thread context class loader
java.lang.Class.forName("oracle.jdbc.driver.OracleDriver", true,
java.lang.Thread.currentThread.getContextClassLoader)


url = "jdbc:oracle:thin:@localhost:1521:xe"
puts "About to connect..."
con = java.sql.DriverManager.getConnection(url, "root", "845emax");
if con
  puts " connection good"
else
  puts " connection failed"
end
