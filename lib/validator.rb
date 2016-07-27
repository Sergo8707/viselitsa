class Validator

  ALPHABET = "ЙЦУКЕНГШЩЗХЪЁФЫВАПРОЛДЖЭЯЧСМИТЬБЮ".split("") #Создаем алфавит (допустимые символы)

  def check_word?(slovo) # проверяем все ли символы в слове входят в наш алфавит
    return false if slovo == ''
    letters = slovo.split("")
    ALPHABET.sort & letters.uniq.sort == letters.uniq.sort
  end

  def check_letter?(letter) #проверяем входит ли буква в наш алфавит
    ALPHABET.include?(letter)
  end

end

