class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  acts_as_token_authenticatable # token based authentication for iphone

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :receipts
  has_many :line_item_users
end
