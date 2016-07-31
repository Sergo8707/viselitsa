# encoding: utf-8
# Основной класс игры. Хранит состояние игры и предоставляет функции
# для развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.)

require 'unicode_utils/upcase' # этот гем преобразует буквы в заданный регистр
require_relative 'validator.rb' # подключаю валидатор

class Game

  attr_reader :letters, :good_letters, :bad_letters, :errors, :status

  # в конструктор передется слово
  def initialize(slovo)
    # инициализирую данные как поля класса
    @letters = get_letters(UnicodeUtils.upcase(slovo))

    @slovo = slovo.encode("utf-8")

    # переменная-индикатор кол-ва ошибок, всего можно сделать не более 7 ошибок
    @errors = 0

    # массивы, хранящие угаданные и неугаданные буквы
    @good_letters = []
    @bad_letters = []

    # спец. поле индикатор состояния игры
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    return slovo.split("")
  end

  # Основной метод игры "сделать следующий шаг"
  # В качестве параметра принимает букву
  def next_step(bukva)

    # Предварительная проверка: если статус игры равен 1 или -1, значит игра закончена,
    # нет смысла дальше делать шаг
    if @status == -1 || @status == 1
      return # выхожу из метода возвращаю пустое значение
    end

    # если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выхожу из метода
    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include? bukva # если в слове есть буква
      @good_letters << bukva # запишу её в число "правильных" буква

      # дополнительная проверка - угадано ли на этой букве все слово целиком
      if @good_letters.uniq.sort == @letters.uniq.sort
        @status = 1 # статус - победа
      end

    else # если в слове нет введенной буквы – добавляю ошибочную букву и увеличиваю счетчик

      @bad_letters << bukva

      @errors += 1

      if @errors >= 7 # если ошибок больше 7 - статус игры -1, проигрышь
        @status = -1
      end
    end
  end

  # Метод, спрашивающий юзера букву и возвращающий ее как результат
  def next_letter

    puts "\nВведите следующую букву"
    letter = ""
    while letter == "" do

      # подключаем валидатор
      validator = Validator.new

      until validator.check_letter?(letter) do

        letter = UnicodeUtils.upcase(STDIN.gets.encode("UTF-8").chomp) # регистр букв

        # проверка для букв е, ё
        if letter == "Ё" && @letters.include?("Е")
          letter = "Е"
        elsif letter == "Е" && @letters.include?("Ё")
          letter = "Ё"
        end

        # проверка для букв и, й
        if letter == "Й" && @letters.include?("И")
          letter = "И"
        elsif letter == "И" && @letters.include?("Й")
          letter = "Й"
        end
      end
    end
    # после получения ввода, передаю управление в основной метод игры
    next_step(letter)
  end
end