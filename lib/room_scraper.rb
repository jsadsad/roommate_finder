class RoomScraper

  def initialize(index_url)
    @index_url = index_url
    @doc = Nokogiri::HTML(open(index_url))
  end

  def call
    rows.each do |row_doc|
      Room.create_from_hash(scrape_row(row_doc)) #=> this SHOULD put room into database
    end
  end

  private
    def rows
      @rows ||= @doc.search('div.content ul.rows li.result-row')
    end

    def scrape_row(row)
      #scrape an individual row
      {
        :date_created => row.search('time').attribute('title').text,
        :title => row.search('p.result-info a').first.children.text,
        :url => row.search('p.result-info a').attribute('href').value,
        :price => row.search('span.result-price').first.text
      }
    end
end
