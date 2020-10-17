class DictionaryReader
  attr_reader :words

  def initialize(filename)
    @words = {}
    File.open(filename).each do |word|
      @words[word.strip] = true
    end
  end
end
