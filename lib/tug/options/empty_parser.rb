class EmptyParser < Parser

  def initialize(options=nil)
    super([])
  end

  private

  def parsed_options(options)
    puts banner
  end
end