class Order < ApplicationRecord
    belongs_to :trip, optional: true
end
