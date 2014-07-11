class EmptyParser < Parser

  def initialize(*options)
    super([])
  end

  private

  def parsed_options(*options)
    puts banner
  end
end