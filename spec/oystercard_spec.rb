require 'oystercard'
describe OysterCard do
  describe '#initialize' do
    it 'should initialize balance to 0' do
      oc = OysterCard.new
      expect(oc.balance).to eq 0
    end
  end
  describe '#balance' do
    it { is_expected.to respond_to :balance }
  end

  describe "#topup" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "Increments balance by argument passed to top_up" do
      topup_amount = 1.20
      expect { subject.top_up(topup_amount) }.to change{ subject.balance }.by topup_amount
    end 
  end 
end
