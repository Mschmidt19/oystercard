require "oystercard"
require "journey"

describe Journey do

  let(:station) { double :station, zone: 1}
  let(:other_station) { double :station, zone: 3}
  let(:my_journey) { Journey.new(station) }

  describe "#initialize" do
    context "not passed a station on initialize" do
      it "initializes @complete to true" do
        expect(subject).to be_complete
      end
    end
    context "passed a station on initialize" do
      it "initializes @complete to false" do
        expect(my_journey).not_to be_complete
      end
    end
  end

  describe "#complete?" do
    it "knows if a journey is complete?" do
      subject.start(station)
      expect(subject).not_to be_complete
    end
  end

  describe "#start" do
    before do
      subject.start(station)
    end
    it "changes complete to false" do
      expect(subject).not_to be_complete
    end
    it "sets @entry_station to the station passed, if there was one passed" do
      expect(subject.entry_station).to eq station
    end
  end

  describe "#finish" do
    before do
      subject.start(station)
      subject.finish(other_station)
    end
    it "changes complete to true" do
      expect(subject).to be_complete
    end
    it "sets @exit_station to the station passed" do
      expect(subject.exit_station).to eq other_station
    end
  end

  describe "#fare" do
    context "journey complete" do
      before do
        subject.start(station)
        subject.finish(other_station)
      end
      it "charges correct fare" do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end
    context "journey not complete" do
      before do
        subject.start(station)
      end
      it "charges a penalty" do
        expect(subject.fare).to eq Journey::PENALTY
      end
    end
  end

end
