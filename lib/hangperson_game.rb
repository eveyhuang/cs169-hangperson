class HangpersonGame


  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(new)
    if new == '' or new == '%' or new == nil
      raise ArgumentError
    end
    new.downcase!
    if (@guesses + @wrong_guesses).include?(new)
      return false
    elsif @word.include?(new)
      @guesses+=new
    else
      @wrong_guesses += new
    end
    true
  end

  def check_win_or_lose
    if @word.chars.uniq.sort == @guesses.chars.sort
      return :win
    elsif @wrong_guesses.length>=7
      return :lose
    else
      return :play
    end
  end

  def word_with_guesses
    curGuesses = ''
    @word.chars do |letter|
      if @guesses.include?(letter)
        curGuesses += letter
      else
        curGuesses += '-'
      end
    end
    return curGuesses
  end

end
