require 'station'

describe Station do

  let(:whitechapel) { Station.new(name: "Whitechapel", zone: 1) }
  let(:mile_end) { Station.new(zone: 2, name: "Mile End") }
  let(:barking) { Station.new(name: "Barking", zone: 4)}

  describe "#name" do
    it "knows it's name" do
      expect(whitechapel.name).to eq "Whitechapel"
    end
  end

  describe "#zone" do
    it "knows it's zone" do
      expect(whitechapel.zone).to eq 1
    end
  end
end
