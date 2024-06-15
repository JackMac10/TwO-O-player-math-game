require './player'
require './question'

class Game
  def initialize
    @players = [Player.new("Player 1"), Player.new("Player 2")]
    @current_player_index = 0
  end

  def start
    until game_over?
      current_player = @players[@current_player_index]
      question = Question.new

      answer = question.ask(current_player.name)
      if question.correct_answer?(answer)
        puts "#{current_player.name}: YES! You are correct."
      else
        puts "#{current_player.name}: Seriously? No!"
        current_player.lose_life
      end

      display_scores
      switch_player
      puts "-----NEW TURN-----" unless game_over?
    end

    announce_winner
  end

  private

  def switch_player
    @current_player_index = (@current_player_index + 1) % 2
  end

  def display_scores
    scores = @players.map { |p| "#{p.name}: #{p.lives}/3" }.join(" vs ")
    puts scores
  end

  def game_over?
    @players.any? { |player| !player.alive? }
  end

  def announce_winner
    winner = @players.find { |player| player.alive? }
    loser = @players.find { |player| !player.alive? }
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "-----GAME OVER-----"
    puts "Good bye!"
  end
end