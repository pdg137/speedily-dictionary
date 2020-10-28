require_relative 'dictionary_reader'

ubuntu_american = DictionaryReader.new('cache/american-english-huge_2019.10.06-1_all.txt')

ubuntu_words = ubuntu_american.words.keys
                 .select { |word| word =~ /\A[a-z]+\Z/ }

contrib_add_words = %w(paul david dan rebecca).collect { |name|
  DictionaryReader.new("contrib/#{name}.add.txt").words.keys
}.flatten

all_words = (
  ubuntu_words + contrib_add_words
).sort.uniq

Dir.mkdir('output') unless File.exists?('output')
output = File.open('output/dictionary.txt', 'w')

all_words.each do |word|
  output.write(word)
  output.write("\n")
end
