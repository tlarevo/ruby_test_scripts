module Foo
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def bar1
      'bar1'
    end
  end

  module ClassMethods
    def bar2
      'bar2'
    end
    def file_name
      File.basename("#{__FILE__}",'.rb')
    end

    def line_number
      __LINE__
    end

    def file_info
      ":#{file_name}:#{line_number}"
    end

    def class_name(object)
      object.class.name
    end
  end
end
