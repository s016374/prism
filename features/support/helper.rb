module Prism
  module Helper
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      # class helper methods
      def hello_class_helper_method
        p 'class_helper_method success'
      end
    end

    # instance helper methods
    def method_missing(method_name, *args, &blk)
      # convert string to classname
      klass = method_name.to_s.split('_').collect(&:capitalize).join
      return eval "Prism::Pages::DM::#{klass}.new" if Module.const_defined? "::Prism::Pages::DM::#{klass}"
      super
    end

    # wait a sec when using poltergeist
    def wait_when_using_poltergeist(explicit_waiting_time = ENV['POLTERGEIST_WAIT_TIME'].to_i)
      sleep explicit_waiting_time ||= 1 if ENV['CAPYBARA_BROWSER'] =~ /poltergeist/
    end
  end
end

module Kernel
  # kernel helper methods
  def hello_prism_kernel_method
    p 'prism_kernel_method success'
  end
end
