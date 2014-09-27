require "spec_helper"

describe ObjectField::Serializer do
  class InSerializedValue
    include ObjectField::Serializer
    attr_accessor :field1, :field2
    serialize :field1
    serialize :field2, as: :attributes
  end

  class SerializeObject; end

  describe ".#included" do
    it "should define singleton method" do
      expect(InSerializedValue.respond_to? :serialize).to be_truthy
    end
  end

  describe "included class" do
    let(:example) { InSerializedValue.new }
    let(:object) { SerializeObject.new }
    let(:stored_instance) do
      example.attributes = object
      example
    end

    it "should define accessor" do
      expect(example.respond_to? :field1_data).to be_truthy
      expect(example.respond_to? :attributes).to be_truthy
    end

    it "should save Object" do
      expect(stored_instance.field2).not_to eq(object)
    end

    it "should parse Object" do
      expect(stored_instance.attributes.class).to eq(SerializeObject)
    end

    it "should generate instance with parse Object" do
      expect(stored_instance.attributes(Struct.new(:value)).value.class).to eq(SerializeObject)
    end
  end
end

