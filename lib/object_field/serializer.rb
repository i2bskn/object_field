module ObjectField
  module Serializer
    module ClassMethods
      def serialize(field_name, as: nil, compression: Zlib::DEFAULT_COMPRESSION)
        define_serializer field_name, (as || accessor_name(field_name)), compression
      end

      private
      def define_serializer(field_name, accessor, compression)
        define_method accessor do |klass=nil|
          value = self.send(field_name)
          return nil if value.nil?
          object = Marshal.load(Zlib.inflate(value))
          klass ? klass.new(object) : object
        end

        define_method "#{accessor}=" do |object|
          self.send "#{field_name}=", Zlib.deflate(Marshal.dump(object), compression)
        end
      end

      def accessor_name(field_name)
        if /(.*)_data/ =~ field_name
          $1.to_sym
        else
          [field_name, :_as_data].join.to_sym
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

