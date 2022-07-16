# Write your code below game_hash
require'./game_hash'

require 'pry'

require 'awesome_print'


# Write code here
def find_player(name)
  return_player = {}

  game_hash.each do |team|
    team[1][:players].each do |player|
      if player[:player_name] == name
        return_player = player
      end
    end
  end
  return_player
end

def all_players
  game_hash[:home][:players] + game_hash[:away][:players]
end

def num_points_scored(name)
 find_player(name)[:points]
end

def shoe_size(name)
  find_player(name)[:shoe]
end

# helper method - find_team
def find_team(team_name)
  team = game_hash.find do |team|
    team[1][:team_name] == team_name
  end
  team[1]
end


def team_colors(team_name)
  find_team(team_name)[:colors]
end


def team_names
[game_hash[:away][:team_name], game_hash[:home][:team_name]]
end

def player_numbers(team_name)
  find_team(team_name)[:players].collect {|player| player[:number]}
end

def player_stats(name)
  find_player(name)
end



# def big_shoe_rebounds
#   size = 0
#   return_player = {}

#   all_players.each { |player| 
#    if player[:shoe] > size
#     size = player[:shoe]
#     return_player = player
#    end
#  }
#  return_player[:rebounds]
# end

def big_shoe_rebounds
all_players.max {|a,b| a[:shoe] <=> b[:shoe]}[:rebounds]
end

def most_points_scored
  all_players.max { |a,b| a[:points] <=> b[:points]}
end

def player_with_longest_name
  all_players.max { |a,b| a[:player_name].length <=> b[:player_name].length}
end

def winning_team
  # home_points = game_hash[:home][:players].sum {|player| player[:points]}
  # away_points = game_hash[:away][:players].sum {|player| player[:points]}
  # [home_points, away_points].max
  winner = {:home => game_hash[:home][:players].sum {|player| player[:points]}, :away => game_hash[:away][:players].sum {|player| player[:points]}}
  game_hash[winner.max[0]][:team_name]
end
puts winning_team