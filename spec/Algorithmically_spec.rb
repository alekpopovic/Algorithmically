# frozen_string_literal: true

require 'rspec'

require_relative '../lib/Algorithmically'

describe Algorithmically do
  context 'include modules correctly' do
    it 'include all Algorithmically modules' do
      expect(described_class.included_modules).to eq(
        [
          Algorithmically::Swarm,
          Algorithmically::Stochastic,
          Algorithmically::Neural,
          Algorithmically::Evolutionary
        ]
      )
    end
  end
  context 'include modules incorrectly' do
    it 'not include all Algorithmically modules' do
      expect(described_class.included_modules).not_to eq(
        []
      )
    end
  end
end