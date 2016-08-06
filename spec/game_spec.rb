# encoding: utf-8
#
# Подключим нашу библиотеку rspec
require 'rspec'
# Подключим класс, game
require_relative '../lib/game'

describe 'Game' do

  #симуляция выигрыша
  it 'wins' do

    game = Game.new('ЁЖ')

    expect(game.status).to eq 0

    game.next_step 'Ж'
    game.next_step 'Ё'

    expect(game.errors).to eq 0
    expect(game.status).to eq 1
  end

  it 'loses' do

    game = Game.new('ЁЖ')

    expect(game.status).to eq 0

    game.next_step 'Ц'
    game.next_step 'А'
    game.next_step 'В'
    game.next_step 'М'
    game.next_step 'О'
    game.next_step 'С'
    game.next_step 'Д'

    expect(game.errors).to eq 7
    expect(game.status).to eq -1
  end
end