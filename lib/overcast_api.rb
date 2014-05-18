require 'overcast_api/version'
require 'httparty'
require 'nokogiri'

module OvercastAPI

  BASE_URL = 'http://oc.tc'

  # Remove <html> & <body>
  def self.enter_container(base_node)
    base_node.xpath "/html/body/div[@class='container']"
  end

  def self.player(username)
    resp = HTTParty.get("#{BASE_URL}/#{username}")
    html = Nokogiri::HTML resp.parsed_response
    Player.new(enter_container(html))
  end

  def self.clean(str)
    str.gsub "\n", ''
  end

  class Player
    attr_reader :username
    attr_reader :status
    attr_reader :ranks
    attr_reader :name_color
    attr_reader :kills
    attr_reader :deaths
    attr_reader :friend_count
    attr_reader :kd_ration
    attr_reader :kk_ratio
    attr_reader :server_joins
    attr_reader :days_played
    attr_reader :raindrops
    attr_reader :monuments
    attr_reader :contacts
    attr_reader :contact_links
    attr_reader :info
    attr_reader :bio
    attr_reader :trophies
    attr_reader :pvp_encounters

    def initialize(container)
      header = container.xpath "section/div[@class='page-header']"
      @username = header.xpath('h1/span').text
      @username.gsub! "\n", ''
      @status = header.xpath('h1/small').text
      @status.gsub! "\n", ''

      row = container.xpath "section/div[@class='row']"

      @ranks = []
      ranks_container = row.xpath "div[@class='span7']/div[@class='row-fluid']/div[@class='span8']/div[@class='row-fluid']/div[@class='span7']/div/span"
      ranks_container.each do |rank_node|
        name = rank_node.text
        color = rank_node['style'].gsub(' ', '').split(';')[0].split(':')[1]
        @ranks << Rank.new(name, color)
      end

      @kills = row.xpath("div[@class='span7']/div[@class='row-fluid']/div[@class='span8']/div[@class='row-fluid']/div[@class='span5']/h2").text
      @kills = @kills.gsub!("\n", '').to_i

      @deaths = row.xpath("div[@class='span7']/div[@class='row-fluid']/div[@class='span4']/h2").text
      @deaths = @deaths.gsub!("\n", '').to_i

      #puts row.xpath("div[@class='span2']/h2")
      @friend_count = row.xpath("div[@class='span2']/h2")[0].text
      @friend_count = @friend_count.gsub!("\n", '').to_i

      stats_list = row.xpath("div[@class='span3']/h2")

      @kd_ratio = stats_list[0].text.gsub!("\n", '').to_f
      @kk_ratio = stats_list[1].text.gsub!("\n", '').to_f
      @server_joins = stats_list[2].text.gsub!("\n", '').to_i
      @days_played = stats_list[3].text.gsub!("\n", '').to_f
      @raindrops = stats_list[4].text.gsub!("\n", '')
      k = @raindrops.include? 'k'
      @raindrops = @raindrops.to_f
      @raindrops *= 1000 if k
      @raindrops = @raindrops.to_i

      info_tabs = container.xpath "section[2]/div[@class='row']/div[@class='span12']/div[@class='tabbable']/div[@class='tab-content']"

      about = info_tabs.xpath "div[@id='about']"
      contacts = about.xpath "div[1][@class='row']/div[@class='span4']"
      @contacts = {}
      @contact_links = {}
      contacts.each do |contact|
        key = contact.xpath("h6").text
        if key == 'Team'
          value = contact.xpath("blockquote/a").text
          link = contact.xpath("blockquote/a")[0]['href']
        else
          value = contact.xpath("blockquote/p/a").text
          link = BASE_URL + contact.xpath("blockquote/p/a")[0]['href']
        end
        @contacts[key] = value
        @contact_links[key] = link
      end

      description = about.xpath "div[2][@class='row']/div[@class='span6']"
      @info = {}
      description.each do |info|
        key = info.xpath("h6").text
        value = info.xpath("pre").text
        @info[key] = value
      end

      @bio = about.xpath("div[3][@class='row']/div[@class='span12']/pre").text

      trophy_case = info_tabs.xpath "div[@id='trophycase']/div/div/ul/li"
      @trophies = []
      trophy_case.each do |trophy|
        div = trophy.xpath('div')[0]
        description = div['title']
        name = div.xpath('h4').text
        icon = div.xpath('div/i')[0]['class']
        trophies << Trophy.new(name, description, icon)
      end

      pvp_encounters = info_tabs.xpath "div[@id='pvp-encounters']/div/div[@class='span6']"
      @pvp_encounters = []
      pvp_encounters.each do |col|
        col.xpath('p').each do |encounter|
          parts = encounter.xpath('a')
          killer = parts[0].children[0]['title']
          victim = parts[1].children[0]['title']
          map = parts[2].text
          time = parts[3]['title']
          @pvp_encounters << PvPEncounter.new(killer, victim, map, time)
        end
      end

    end

  end

  class Rank
    attr_reader :name
    attr_reader :color
    def initialize(name, color)
      @name = name
      @color = color
    end
  end

  class Trophy
    attr_reader :name
    attr_reader :description
    attr_reader :icon # The FontAwesome icon
    def initialize(name, description, icon)
      @name = name
      @description = description
      @icon = icon
    end
  end

  class PvPEncounter
    attr_reader :killer
    attr_reader :victim
    attr_reader :map
    attr_reader :time
    def initialize(killer, victim, map, time)
      @killer = killer
      @victim = victim
      @map = map
      @time = time
    end
  end

end
