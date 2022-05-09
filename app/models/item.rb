class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  # field :for_search, type: Boolean
  field :locator, type: String
  field :indentifier, type: String

  embedded_in :listen

  validate :locator_included
  def locator_included
    errors.add(:item, 'Locator deve ser: css ou xpath ') unless ["css", "xpath"].include? locator
  end

  validates_presence_of :locator
end

# site (ora, o site que devo scrapar)
# url nome_id searched_item wanted_items
#
# searched_item (itens que será buscado para realizar a comparação)
# id distinguer locator indentifier
#
# "distinguer" pode ser: innerhtml_is, innerhtml_include ...
#   "locator" poder ser : css, xpath ...
#   "indentifier" é o valor esperado para o locator
#
# wanted_item (itens que será extraído para alimentar o feed)
# id distinguer locator indetifer type src
#
# "type" e "src" são opcionais. Type indica se o itens é um text plain data ou um file data. Em caso de file data, será interessante que possua uma url para acesso ou exibição (em caso de imagem)
