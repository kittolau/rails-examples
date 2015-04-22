module Foo
    extend ActiveSupport::Concern
    included do
        #call back to call some method on host
        self.send(:do_host_something)
    end

   module ClassMethods
      def bite
        # do something
      end
   end

   module InstanceMethods
      def poke
         # do something
      end
   end
end
