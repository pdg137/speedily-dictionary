require_relative 'dictionary_reader'

STDERR.puts "Using base dictionaries: #{ENV['BASE_DICTIONARIES']}"

base_dictionaries = ENV['BASE_DICTIONARIES']
                      .split(' ')
                      .map { |f| DictionaryReader.new(f) }

base_words = base_dictionaries
               .map(&:words)
               .map(&:keys)
               .flatten
               .select { |word| word =~ /\A[a-z]+\Z/ }

contrib_add_words = %w(paul david dan rebecca).collect { |name|
  DictionaryReader.new("contrib/#{name}.add.txt").words.keys
}.flatten

contrib_remove_words = %w(paul).collect { |name|
  DictionaryReader.new("contrib/#{name}.remove.txt").words.keys
}.flatten

all_words = (
  base_words + contrib_add_words - contrib_remove_words
).sort.uniq

all_words.each do |word|
  puts word
end
