class Blog < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories 

  validates :title, :sub_title, presence: true 
end
