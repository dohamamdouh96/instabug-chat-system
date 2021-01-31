class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.increment_number(lastRecord)
    if lastRecord 
      return @number = lastRecord.number + 1
    else
      return @number = 1
    end
  end

end
