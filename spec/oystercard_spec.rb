require "oystercard"
describe OysterCard do

  let(:oc) { OysterCard.new }
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  let(:journey){ {:entry=>entry_station, :exit=>exit_station} }

  describe "#initialize" do
    it "Should initialize balance to 0.00" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#balance" do
    it { is_expected.to respond_to :balance }
  end

  describe "#pretty_balance" do
    it { is_expected.to respond_to :pretty_balance }
    it "displays balance in a very readable way" do
      oc.top_up(35.75)
      expect(oc.pretty_balance).to eq "£35.75"
    end
    it "works even when balance is between 0 and 3 digits" do
      expect(oc.pretty_balance).to eq "£0.00"
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "Increments balance by argument passed to top_up (in pence)" do
      expect { subject.top_up(1.20) }.to change{ subject.balance }.by 120
    end
    it "Raises an error if top up amount will cause balance to exceed maximum limit" do
      topup_amount = 95.00
      expect { subject.top_up(topup_amount) }.to raise_error("Balance cannot exceed #{OysterCard::MAXIMUM_LIMIT.to_f / 100}")
    end
  end

  # describe "#in_journey?" do
  #   it { is_expected.to respond_to :in_journey? }
  #   it "initializes as false" do
  #     expect(subject).not_to be_in_journey
  #   end
  #   context "Has minimum fare" do
  #     before do
  #       oc.top_up(30.00)
  #     end
  #     it "returns a boolean" do
  #       oc.touch_in(entry_station)
  #       expect(oc.in_journey?).to be(true).or be(false)
  #       oc.touch_out(exit_station)
  #       expect(oc.in_journey?).to be(true).or be(false)
  #     end
  #   end
  # end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it "Raises an error if balance is not greater than the minimum fare" do
      expect { subject.touch_in(entry_station) }.to raise_error("You must have a minimum balance of #{OysterCard::MINIMUM_FARE.to_f / 100} before touching in")
    end
    context "Has minimum fare" do
      before do
        oc.top_up(30.00)
      end
      it "Changes in_journey to true" do
        oc.touch_in(entry_station)
        expect(oc).to be_in_journey
      end
      it "stores the entry station" do
        oc.touch_in(entry_station)
        expect(oc.list_of_journies.last[:entry]). to eq entry_station
      end
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    context "Has minimum fare" do
      before do
        oc.top_up(30.00)
      end
      it "Changes in_journey to false" do
        oc.touch_in(entry_station)
        oc.touch_out(exit_station)
        expect(oc).not_to be_in_journey
      end
      it "Charges minimum fare for the journey (in pence)" do
        oc.touch_in(entry_station)
        expect { oc.touch_out(exit_station) }.to change{ oc.balance }.by(-180)
        # expect(oc.balance).to eq 28.20
      end
      it "Pushes the completed journey to list_of_journeys" do
        oc.touch_in(entry_station)
        oc.touch_out(exit_station)
        # Checks that the most recent addition to the array is the new journey
        expect(oc.list_of_journies.last).to eq journey
      end
    end
  end

  describe "#list_of_journies" do
    context "Has minimum fare" do
      before do
        oc.top_up(30.00)
      end
      it "initializes as an empty array" do
        expect(oc.list_of_journies).to be_empty
      end
      it "stores a journey" do
        oc.touch_in(entry_station)
        oc.touch_out(exit_station)
        expect(oc.list_of_journies).to include journey
      end
    end
  end
end
