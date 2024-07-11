
class Morpion
  attr_reader :board, :players, :player_names

  def initialize
    @board = {
      'A1' => ' ', 'A2' => ' ', 'A3' => ' ',
      'B1' => ' ', 'B2' => ' ', 'B3' => ' ',
      'C1' => ' ', 'C2' => ' ', 'C3' => ' '
    }

    @players = ['X', 'O']
    @player_names = []

    # Demander les prénoms des joueurs
    @players.each do |player|
      print "Joueur #{player}, entrez votre prénom : "
      @player_names << gets.chomp.capitalize
    end
  end

  def display_board
    puts " "
    puts "    1   2   3 "
    puts "  -------------"
    puts "A | #{board['A1']} | #{board['A2']} | #{board['A3']} |"
    puts "  -------------"
    puts "B | #{board['B1']} | #{board['B2']} | #{board['B3']} |"
    puts "  -------------"
    puts "C | #{board['C1']} | #{board['C2']} | #{board['C3']} |"
    puts "  -------------"
    puts " "
  end

  def winner?(player)
    winning_combinations = [
      ['A1', 'A2', 'A3'], ['B1', 'B2', 'B3'], ['C1', 'C2', 'C3'], # lignes
      ['A1', 'B1', 'C1'], ['A2', 'B2', 'C2'], ['A3', 'B3', 'C3'], # colonnes
      ['A1', 'B2', 'C3'], ['A3', 'B2', 'C1'] # diagonales
    ]

    winning_combinations.any? do |combo|
      combo.all? { |position| board[position] == player }
    end
  end

  def play_game
    loop do
      display_board

      # Demander au joueur où il souhaite jouer
      puts "#{player_names[0]} (#{players[0]}), à vous de jouer : "
      move = gets.chomp.upcase

      # Vérifier si le mouvement est valide et mettre à jour le plateau
      if board.key?(move) && board[move] == ' '
        board[move] = players[0]
      else
        puts "Mouvement invalide. Veuillez choisir une case libre (ex: A1, B2, C3)."
        next
      end

      # Vérifier s'il y a un gagnant ou s'il y a égalité
      if winner?(players[0])
        display_board
        puts "Félicitations, #{player_names[0]} (#{players[0]}) ! Vous avez gagné !"
        break
      elsif board.none? { |_, value| value == ' ' }
        display_board
        puts "Match nul !"
        break
      end

      # Changer de joueur pour le tour suivant
      players.rotate!
      player_names.rotate!
    end

    # Demander si les joueurs veulent jouer une nouvelle partie
    print "Voulez-vous jouer une nouvelle partie ? (oui/non) : "
    replay = gets.chomp.downcase

    if replay == 'oui'
      Morpion.new.play_game
    else
      puts "Merci d'avoir joué ! À bientôt !"
    end
  end
end
