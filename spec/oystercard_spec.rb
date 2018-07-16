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
  end 
end
