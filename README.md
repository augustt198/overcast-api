# OvercastAPI

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

Get a player with `OvercastAPI.player`

```ruby
player = OvercastAPI.player 'monsieurapple'
```

Full output:
```
#<OvercastAPI::Player:0x007faea9def440 
    @username="MonsieurApple",
    @status="Online",
    @ranks=[
        #<OvercastAPI::Rank:0x007faea9dec628 @name="Administrator", @color="#FA0">,
        #<OvercastAPI::Rank:0x007faea9dec240 @name="Developer", @color="purple">
        ],
    @kills=5604,
    @deaths=4131,
    @friend_count=182,
    @kd_ratio=1.357,
    @kk_ratio=1.728,
    @server_joins=8555,
    @days_played=9.24,
    @raindrops=29100,
    @contacts={
        "Twitter"=>"Monsieur_Apple", "Facebook"=>"OvercastNetwork", "YouTube"=>"mrapplecomputer1",
        "Twitch"=>"MonsieurApple", "Github"=>"mrapple"
    },
    @contact_links={
        "Twitter"=>"http://twitter.com/Monsieur_Apple", "Facebook"=>"http://facebook.com/OvercastNetwork",
        "YouTube"=>"http://youtube.com/user/mrapplecomputer1", "Twitch"=>"http://twitch.tv/MonsieurApple",
        "Github"=>"https://github.com/mrapple"
    },
    @info={
        "Gender"=>"Male", "Location"=>"United States of America",
        "Occupation"=>"Co-Owner of Overcast Network", "Interests"=>"Computer Science"
    },
    @bio="",
    @trophies=[
        #<OvercastAPI::Trophy:0x007faea9dc7da0 @name="Chick Magnet", @description="Have the cutest skin on Overcast", @icon="icon-magnet">,
        #<OvercastAPI::Trophy:0x007faea9dc6fe0 @name="Official Business", @description="Be a member of the staff", @icon="icon-user-md">,
        #<OvercastAPI::Trophy:0x007faea9dc53e8 @name="Ref", @description="Referee a tournament", @icon="icon-flag">,
        #<OvercastAPI::Trophy:0x007faea9dc46f0 @name="Sign Me Up", @description="Register and confirm email address", @icon="icon-edit">
    ],
    @pvp_encounters=[
        #<OvercastAPI::PvPEncounter:0x007faea9dbf880 @killer="SheriffSoco", @victim="MonsieurApple", @map="Sunburn", @time="May 17th, 2014 -  1:11 PM">,
        #<OvercastAPI::PvPEncounter:0x007faea9dbf3a8 @killer="Th3Cryton", @victim="MonsieurApple", @map="Sunburn", @time="May 17th, 2014 -  1:11 PM">,
        #<OvercastAPI::PvPEncounter:0x007faea9dbeea8 @killer="MonsieurApple", @victim="SheriffSoco", @map="Sunburn", @time="May 17th, 2014 -  1:10 PM">
        ...
    ],
    @infractions=[]
> 
```
