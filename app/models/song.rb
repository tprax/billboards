class Song < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :billboard, optional: true
end
