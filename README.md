# Mastermind

[Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) is a two-player board game created in 1970 by [Mordecai Meirowitz](https://en.wikipedia.org/wiki/Mordecai_Meirowitz). This gem provides an API for building this game, as well as a demonstration version that can be run in the console.

In the game, one player is assigned the role of "Code Maker" and the other "Code Breaker". The Code Maker creates a secret code sequence, which is represented by four pegs, each of one of six colors. The Code Breaker then has 12 attempts to determine what the secret code sequence is, with information on how many pegs were matched with the correct color in the correct position or a correct color in an incorrect position.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mastermind-game'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mastermind-game

## Usage

If you are using bundler, a demonstration of this game can be run in the terminal once the gem is installed:

```bash
$ mastermind
```

### Game

The `Mastermind::Game` object is the primary point of interaction. Instances of this object contain all the information for a complete game.

```ruby
# Instantiate a game with a random secret
# :codemaker and :codebreaker are optional and can be any object
game = Mastermind::Game.new(codemaker: ..., codebreaker: ...)

# Prepare a guess
guess = Mastermind::Game::Code.from([:red, :red, :red, :red])
game.guess(guess)

# Find how many turns there have been
game.attempts # => 1

# Check if the game is over
game.over? # => false

# Determine who has won
# Returns the codemaker, the codebreaker, or nil
game.winner # => nil
```

### Knuth Algorithm

In 1977, Donald Knuth developed an algorithm by which the correct code can be guessed in at most five turns. An implementation of this algorithm is included with this gem. To make use of it, create a new instance of the Knuth algorithm, supplying a game object:

```ruby
game = Mastermind::Game.new
knuth = Mastermind::Knuth.new(game)
guess = knuth.prepare_guess
game.guess(guess)
```

A first guess can be obtained almost instantly. However, due to this problem being NP-Complete, the second guess may take several seconds. Follow-on guesses will take less time due to fewer possibilities remaining.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lamarseillaise/mastermind.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
