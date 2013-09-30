require_relative 'test_module'

class Test
  include Foo

  def testing
    ClassMethods::class_name(self)
  end
end

puts Test.new.bar1
puts Test.bar2
puts Test.file_info
puts Test.new.testing