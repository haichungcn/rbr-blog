class User < ApplicationRecord
  has_many :comments, dependent: :destroy
end
