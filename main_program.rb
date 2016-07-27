current_path = "./" + File.dirname(__FILE__)

require 'unicode_utils'
require_relative 'lib/win.rb'
require_relative 'lib/game.rb'
require_relative 'lib/result_printer.rb'
require_relative 'lib/validator.rb'
require_relative 'lib/word_reader.rb'

puts "Игра виселица."

# создаем объект, печатающий результаты
printer = ResultPrinter.new

# подключаем валидатор
validator = Validator.new

# создаем объект, отвечающий за ввод слова в игру
word_reader = WordReader.new

# Имя файла, откуда брать слово для загадывания
words_file_name = current_path + "/data/words.txt"

# создаем объект типа Game, в конструкторе передаем загаданное слово из word_reader-а
slovo = word_reader.read_from_file(words_file_name)
slovo = UnicodeUtils::upcase(slovo)

abort "Слово содержит недопустимые символы! Допустимы только буквы русского алфавита" unless validator.check_word?(slovo)

game = Game.new(slovo)

# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
while game.status == 0 do
  # выводим статус игры
  printer.print_status(game)
  # просим угадать следующую букву
  puts
  puts "Введите следующую букву"

  letter = ''

  until validator.check_letter?(letter) do
    letter = STDIN.gets.chomp.encode('UTF-8')
    letter = UnicodeUtils::upcase(letter)
    letter = 'И' if letter == 'Й'
    letter = 'Е' if letter == 'Ё'
  end

  game.next_step(letter)
end

printer.print_status(game)
