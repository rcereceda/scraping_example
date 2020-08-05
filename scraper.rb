class Scraper
  attr_accessor :parse_page, :items, :options

  def initialize
    agent = Mechanize.new
    url = 'https://www.santander.cl'
    page = agent.get(url)
    login_form = page.forms[0]
    login_form['rut'] = '150202493'
    login_form['pin'] = '2373'
    login_form.submit
    destination = "https://www.santander.cl/transa/productos/saldoC/SaldoCnvo/saldoc.asp?tkn=61"
    @parse_page ||= agent.get(destination)
    @items = []
  end

  def set_items
    item_container.each_with_index do |item, index|
      next if index < 3

      item = Item.new(item.children[1].text,
                      item.children[7].text)
      @items.push(item)
    end
  end

  private

    def item_container
      parse_page.at('table').search('tr').at('table').search('tr')
    end
end
