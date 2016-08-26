module MangaFetch::Downloader
  # Download an image defined with `src` in the directory `prefix`. It uses `@agent` by default
  def download_image(src: nil, prefix: "/tmp", agent: nil)
    image = (agent || @agent).get src
    path = File.expand_path image.uri.to_s.split("/")[-3..-1].join("/"), prefix
    Dir.mkdir File.expand_path image.uri.to_s.split("/")[-3..-3].join("/"), prefix rescue nil
    Dir.mkdir File.expand_path image.uri.to_s.split("/")[-3..-2].join("/"), prefix rescue nil
    File.write path, image.body
    STDERR.puts "File [".blue + path.yellow + "] saved".blue
  end
end
