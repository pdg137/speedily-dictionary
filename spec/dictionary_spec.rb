require_relative '../lib/dictionary_reader.rb'

file = 'output/dictionary.txt'
words = DictionaryReader.new(file).words

describe file do
  it 'contains only lowercase letters' do
    expect(words.keys.select { |w| w =~ /[^a-z]/ }).to be_empty
  end

  %w(alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega).each do |letter|
    it "contains greek letter #{letter}" do
      expect(words[letter]).to eq(true)
    end

    it "contains the plural greek letter #{letter}s" do
      expect(words[letter+'s']).to eq(true)
    end
  end

  %w(qaid qadi atomise).each do |word|
    it "contains known word #{word}" do
      expect(words[word]).to eq(true)
    end
  end

  %w(emmy).each do |word|
    it "removed word #{word} got removed" do
      expect(words[word]).to eq(nil)
    end
  end
end
