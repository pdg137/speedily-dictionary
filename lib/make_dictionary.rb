require_relative 'dictionary_reader'

ubuntu_american = DictionaryReader.new('cache/american-english-huge_2019.10.06-1_all.txt')

words = ubuntu_american.words.keys
          .select { |word| word =~ /\A[a-z]+\Z/ }

output = File.open('cache/dictionary.txt', 'w')

words.sort.each do |word|
  output.write(word)
  output.write("\n")
end
