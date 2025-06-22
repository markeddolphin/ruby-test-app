class Product < ApplicationRecord
    has_many :feedbacks

    def average_rating
        feedbacks.average(:rating)&.round(2) || 0
    end

    def count_rating
        feedbacks.count(:rating) || 0
    end
end
