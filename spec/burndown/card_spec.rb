require 'spec_helper'

module Burndown
  describe Card do
    subject(:card) { Card.new name: name }

    describe '#estimative' do
      subject { card.estimative }

      context 'without estimative' do
        let(:name) { 'easy card without estimative' }

        it { expect(subject).to eq(nil) }
      end

      context 'with estimative and real effort' do
        let(:name) { '[4](3) without estimative' }

        it { expect(subject).to eq(3) }
      end

      let(:name) { '(3) easy card' }

      it { expect(subject).to eq(3) }
    end
  end
end
