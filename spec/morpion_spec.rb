require 'rspec'
require_relative '../lib/morpion'

RSpec.describe Morpion do
  let(:game) { Morpion.new }

  it 'initializes a board with 9 empty spaces' do
    expect(game.board.values.count(' ')).to eq(9)
  end

  it 'can display the board' do
    expect { game.display_board }.to output.to_stdout
  end

  it 'can check for a winner' do
    game.board['A1'] = 'X'
    game.board['A2'] = 'X'
    game.board['A3'] = 'X'
    expect(game.winner?('X')).to be true
  end

  it 'can rotate players' do
    current_player = game.players.first
    game.players.rotate!
    expect(game.players.first).not_to eq(current_player)
  end
end
