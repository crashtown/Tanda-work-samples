class Device < ApplicationRecord
  has_many :epoches, dependent: :delete_all
end
