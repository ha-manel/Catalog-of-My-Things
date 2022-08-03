require_relative '../game'

describe Game do
  it 'Should be an instance of Game' do
    author = Game.new('Jordan', '04-12-2011', '09-10-2017')
    expect(author).to be_instance_of Game
  end

  it 'archived should be true' do
    game = Game.new('Jordan', '04-12-2011', '09-10-2017')
    game.move_to_archive
    game.archived.should eq true
  end

  it 'archived should be true' do
    game = Game.new('Jordan', '04-12-2011', '09-10-2017')
    game.archived.should eq false
  end

  it 'Should store game in json file' do
    game = Game.new('Jordan', '04-12-2011', '09-10-2017')
    game.add_game
    expect(File.exist?('games.json') && File.read('games.json') != '').to eq true
  end
end
