require "mechanize"
require "colorize"

module MangaFetch
end

require_relative "manga_fetch/downloader"
require_relative "manga_fetch/fetcher"

module MangaFetch
  include Downloader
  include Fetcher
  extend self
end
