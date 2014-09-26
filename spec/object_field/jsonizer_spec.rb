require "spec_helper"

describe ObjectField::Jsonizer do
  class Example
    include ObjectField::Jsonizer
    attr_accessor :field1_json, :field2, :field3_json
    jsonize :field1_json, :field2
    jsonize :field3_json, as: :attributes
  end

  describe ".#included" do
    it "should define singleton method" do
      expect(Example.respond_to? :jsonize).to be_truthy
    end
  end

  it "not possible to specify more than one accessor" do
    expect{Example.jsonize(:field1, :field2, as: :field_name)}.to raise_error(ArgumentError)
  end

  describe "included class" do
    let(:example) { Example.new }
    let(:hash) { {key: :value} }
    let(:stored_instance) do
      example.attributes = hash
      example
    end

    it "should define accessor" do
      expect(example.respond_to? :field1).to be_truthy
      expect(example.respond_to? :field2_as_json).to be_truthy
      expect(example.respond_to? :attributes).to be_truthy
    end

    it "should save JSON value" do
      expect(stored_instance.field3_json).to eq(Oj.dump(hash))
    end

    it "should parse JSON value" do
      expect(stored_instance.field3_json).not_to eq(hash)
      expect(stored_instance.attributes).to eq(hash)
    end

    it "should generate instance with parse JSON value" do
      expect(stored_instance.attributes(Struct.new(:value)).value).to eq(hash)
    end
  end
end

