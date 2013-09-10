class Event < ActiveRecord::Base

  validates :description, :area, :starts_at, :ends_at, presence: true

end
