require_relative "downloader"

class MangaFetch::Fetcher
  include MangaFetch::Downloader

  # Fetch some pages form the manga named like `name`
  def fetch(name: "berserk", num: nil, download: false, dir: nil)
    init_agent(url: "http://www.mangareader.net/#{name}")

    images = if num.is_a? Fixnum
      [ fetch_one(num: num, download: download, dir: dir) ]
    elsif num.is_a? Enumerable
      fetch_list(nums: num, download: download, dir: dir)
    end
  end

  private def init_agent(url: nil)
    @agent = Mechanize.new
    @agent.get url
    @main = @agent.page
  end

  # fetch every images of the tome `num` loaded in `@main`
  def fetch_one(num: 1, download: false, dir: nil)
    link = "#{@main.uri.to_s}/#{num}"
    STDERR.puts "Fetching Tome [".blue + "#{num}".yellow + "]".blue if $verbose
    first_page = @agent.get(link)

    last_page_num = first_page.at("#selectpage").text.split.last.to_i
    (1..last_page_num).map do |i|
      STDERR.puts "Fetching Tome [".blue + "#{num}".yellow + "] Image [".blue + "#{i} / #{last_page_num}".yellow + "]".blue if $verbose
      current_page = @agent.get "#{first_page.uri.to_s}/#{i}"
      image = current_page.at("#img")[:src]
      STDERR.puts "[#{download ? "D" : "S"}] -> ".blue + image.red if $verbose
      download_image(src: image, prefix: dir) if download
      image
    end
  end

  # fetch every images of the tomes `nums` loaded in `@main`
  def fetch_list(nums: nil, download: false, dir: nil)
    ones = []
    nums.map{|num| ones << fetch_one(num: num, download: download, dir: dir) }
    ones
  end
end
