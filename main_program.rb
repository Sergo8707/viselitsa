require_relative 'lib/win.rb'
require_relative 'lib/game.rb'
require_relative 'lib/result_printer.rb'
require_relative 'lib/word_reader.rb'
require_relative 'lib/validator.rb'

# создаем объект, печатающий результаты
printer = ResultPrinter.new

# создаем объект, отвечающий за ввод слова в игру
word_reader = WordReader.new

# Имя файла, откуда брать слово для загадывания
current_path = "./" + File.dirname(__FILE__)
words_file_name = current_path + "/data/words.txt"

# Так же можно загадать слово и передать его через аргумент
if ARGV.empty?
  game = Game.new(word_reader.read_from_file(words_file_name))
else
  game = Game.new(word_reader.read_from_args)
end
# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
while game.status == 0 do
  # выводим статус игры
  printer.print_status(game)
  # просим угадать следующую букву

  game.next_letter
end

printer.print_status(game)
