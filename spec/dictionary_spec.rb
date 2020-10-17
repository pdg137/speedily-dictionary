require_relative '../lib/dictionary_reader.rb'

file = 'cache/dictionary.txt'
words = DictionaryReader.new(file).words

describe file do
  it 'contains only lowercase letters' do
    expect(words.keys.select { |w| w =~ /[^a-z]/ }).to be_empty
  end

  %w(alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega).each do |letter|
    it "contains greek letter #{letter}" do
      expect(words[letter]).to eq(true)
    end
  end
end
