class ForemanCommand
  def initialize(rota)
    @apprentice_rota = rota
  end

  def run()
    "The foreman for this week is #{@apprentice_rota.foremanName()}"
  end

  def applies_to(request)
    request.start_with?("foreman")
  end
end
