class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_random
    limit(1).order("RANDOM()").first
  end
end
