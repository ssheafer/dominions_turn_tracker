class Status < ClassyEnum::Base
  enum_classes :Pending, :Active, :Finished
end

class StatusPending < Status
end

class StatusActive < Status
end

class StatusFinished < Status
end

