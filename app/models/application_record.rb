class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.increment_number(records)
    @previous_record = records.last

    if @previous_record 
      return @number = @previous_record.number + 1
    else
      return @number = 1
    end
  end

end
