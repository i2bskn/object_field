module ObjectField
  module Jsonizer
    module ClassMethods
      def jsonize(*args, as: nil)
        if as && args.size > 1
          raise ArgumentError, "It is not possible to specify more than one accessor"
        end

        args.each {|arg| define_jsonizer arg.to_sym, (as || accessor_name(arg))}
      end

      private
      def define_jsonizer(field_name, accessor)
        define_method accessor do |klass=nil|
          value = self.send(field_name)
          return nil if value.nil?
          object = Oj.load(value)
          klass ? klass.new(object) : object
        end

        define_method "#{accessor}=" do |object|
          self.send("#{field_name}=", Oj.dump(object))
        end
      end

      def accessor_name(field_name)
        if /(.*)_json$/ =~ field_name
          $1.to_sym
        else
          [field_name, :_as_json].join.to_sym
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

