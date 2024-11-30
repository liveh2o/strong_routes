module StrongRoutes
  module Accessorable
    # Creates an accessor that simply sets and reads a key in the hash:
    #
    #   class Config < Hash
    #     hash_accessor :app
    #   end
    #
    #   config = Config.new
    #   config.app = Foo
    #   config[:app] #=> Foo
    #
    #   config[:app] = Bar
    #   config.app #=> Bar
    #
    def hash_accessor(*names) # :nodoc:
      names.each do |name|
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{name}
            self[:#{name}]
          end

          def #{name}=(value)
            self[:#{name}] = value
          end

          def #{name}?
            !! self[:#{name}]
          end
        METHOD
      end
    end
  end

  class Config < Hash
    extend Accessorable

    hash_accessor :allowed_routes,
      :enabled,
      :insert_after,
      :insert_before,
      :message

    def initialize(*)
      super

      self[:enabled] = true if self[:enabled].nil?
      self[:message] = "Resource Not Found" if self[:message].nil?
    end
  end
end
