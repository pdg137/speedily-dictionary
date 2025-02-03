require_relative 'dictionary_reader'

base_american = DictionaryReader.new(ENV['DICT_AMERICAN_HUGE'])
base_british = DictionaryReader.new(ENV['DICT_BRITISH_HUGE'])

american_words = base_american.words.keys
                   .select { |word| word =~ /\A[a-z]+\Z/ }

british_words = base_british.words.keys
                  .select { |word| word =~ /\A[a-z]+\Z/ }

contrib_add_words = %w(paul david dan rebecca).collect { |name|
  DictionaryReader.new("contrib/#{name}.add.txt").words.keys
}.flatten

contrib_remove_words = %w(paul).collect { |name|
  DictionaryReader.new("contrib/#{name}.remove.txt").words.keys
}.flatten

all_words = (
  american_words + british_words + contrib_add_words - contrib_remove_words
).sort.uniq

all_words.each do |word|
  puts word
end
