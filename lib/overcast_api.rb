require 'overcast_api/version'
require 'httparty'
require 'nokogiri'

module OvercastApi

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
    attr_reader :monuments

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

end
