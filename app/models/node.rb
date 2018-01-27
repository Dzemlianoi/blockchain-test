class Node < ApplicationRecord
  validates_presence_of :id, :url
end
