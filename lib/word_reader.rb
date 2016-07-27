class WordReader

  def read_from_args
    return ARGV[0]
  end

  # Метод, возвращающий случайное слово, прочитанное из файла,
  # имя файла передается как аргумент метода
  def read_from_file(file_name)
    # проверка, если файла не существует. Добавляем обработку исключений.
    begin
      f = File.new(file_name, "r:UTF-8") # открываем файл, явно указывая его кодировку
      lines = f.readlines # читаем все строки в массив
      f.close # закрываем файл
    rescue Errno::ENOENT
      puts "Не удалось открыть файл #{filename}"
    end

    return lines.sample.chomp
    # возвращаем случайную строчку из прочитанного массива,
    # удаляем в конце символ перевода строки методом chomp
  end
end

