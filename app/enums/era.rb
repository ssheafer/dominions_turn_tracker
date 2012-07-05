class Era < ClassyEnum::Base
  enum_classes :EA, :MA, :LA, :Other
end

class EraEA < Era
end

class EraMA < Era
end

class EraLA < Era
end

class EraOther < Era
end

