require 'rubygems'
require 'bundler/setup'
require 'json'
require 'multi_json'
require 'sinatra'
require 'sinatra/json'
require 'dalli'
require 'memcachier'

require_relative './board'
require_relative './puzzler'

cache = Dalli::Client.new

get '/' do
  "Nothing to see here, move along folks"
end

get '/puzzle.json' do
  i = cache.get('last_board_id').to_i
  board = Puzzler.new_puzzle(i + 1)
  cache.set('last_board_id', board.id)
  cache.set("board-#{board.id}", board.storage)
  json({id: board.id, hints: board.hints})
end

post '/puzzle.json' do
  board_id = params[:board_id]
  board_string = params[:solution]
  cached = cache.get("board-#{board_id}")
  solved = Puzzler.solve_puzzle(board_id, board_string, cached)
  json({solved: solved})
end
