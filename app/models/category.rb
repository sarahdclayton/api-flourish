class Category < ApplicationRecord
    has_and_belongs_to_many :blogs 

    validates name, presence :true 
end
