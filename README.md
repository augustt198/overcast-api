# OvercastApi

Gem for getting information from the Overcast Network website 

## Installation

Add this to your Gemfile:

```ruby
gem 'overcast_api', github: 'augustt198/overcast-api'
```

## Usage

First, require `overcast_api` in your file

```ruby
require 'overcast_api'
```

Get a player with `OvercastApi.player`

```ruby
player = OvercastApi.player('monsieurapple')

player.kills # => 5604

=> #<OvercastApi::Player:0x007fd11215a1e0
    @username="MonsieurApple", @status="Seen about 14 hours ago",
    @ranks=[
        #<OvercastApi::Rank:0x007fd11214bb68 @name="Administrator", @color="#FA0">,
        #<OvercastApi::Rank:0x007fd11214af38 @name="Developer", @color="purple">
    ],
    @kills=5604, @deaths=4131,
    @friend_count=182,
    @kd_ratio=1.357,
    @kk_ratio=1.728,
    @server_joins=8553,
    @days_played=9.24,
    @raindrops=29100> 
```
