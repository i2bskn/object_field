module ObjectField
  module Serializer
    module ClassMethods
      def serialize(field_name, as: nil, compression: Zlib::DEFAULT_COMPRESSION)
        accessor = as || accessor_name(field_name)
        define_method accessor do |klass=nil|
          object = Marshal.load(Zlib.inflate(self.send(field_name)))
          klass ? klass.new(object) : object
        end

        define_method "#{accessor}=" do |object|
          self.send "#{field_name}=", Zlib.deflate(Marshal.dump(object), compression)
        end
      end

      private
      def accessor_name(field_name)
        [field_name, :_data].join.to_sym
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

