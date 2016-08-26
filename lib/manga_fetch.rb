require "mechanize"
require "colorize"

module MangaFetch
  extend self

  # Fetch some pages form the manga named like `name`
  def fetch(name: "berserk", num: nil)
    init_agent("http://www.mangareader.net/#{name}")

    images = if num.is_a? Fixnum
      [ fetch_one(num) ]
    elsif num.is_a? Enumerable
      fetch_list(num)
    end
  end

  def init_agent(url)
    @agent = Mechanize.new
    @agent.get url
    @main = @agent.page
  end

  def fetch_one(num)
    link = "#{@main.uri.to_s}/#{num}"
    STDERR.puts "Fetching Tome [".blue + "#{num}".yellow + "]".blue if $verbose
    first_page = @agent.get(link)

    last_page_num = first_page.at("#selectpage").text.split.last.to_i
    (1..last_page_num).map do |i|
      STDERR.puts "Fetching Image [".blue + "#{i} / #{last_page_num}".yellow + "]".blue if $verbose
      current_page = @agent.get "#{first_page.uri.to_s}/#{i}"
      image = current_page.at("#img")[:src]
      STDERR.puts "-> ".blue + image.red if $verbose
    end
  end

  def fetch_list(nums)
    nums.map{|num| fetch_one(num)}
  end
end
