class DictionaryReader
  attr_reader :words

  def initialize(filename)
    @words = {}
    File.open(filename, 'r:iso-8859-1').each do |word|
      @words[word.strip] = true
    end
  end
end
