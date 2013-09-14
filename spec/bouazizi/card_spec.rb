require 'spec_helper'

module Bouazizi
  describe Card do
    subject(:card) { Card.new name: name }

    describe '#metrics' do
      subject { card.metrics }

      context 'without metrics' do
        let(:name) { 'easy card without metrics' }

        it { expect(subject).to eq({}) }
      end

      context 'with only estimative' do
        let(:name) { '(3) easy card' }

        it { expect(subject[:estimative]).to eq(3) }
        it { expect(subject[:real_effort]).to eq(nil) }
      end

      context 'with only real effort' do
        let(:name) { '[3] easy card' }

        it { expect(subject[:estimative]).to eq(nil) }
        it { expect(subject[:real_effort]).to eq(3) }
      end

      context 'with estimative and real effort' do
        let(:name) { '[4](3) without estimative' }

        it { expect(subject[:estimative]).to eq(3) }

        it { expect(subject[:real_effort]).to eq(4) }
      end

    end
  end
end
