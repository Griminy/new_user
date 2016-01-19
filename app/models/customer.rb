class Customer < ActiveRecord::Base
  self.table_name = "customers"
  validates :sum, presence: true,  :numericality =>  { greater_than: 1, less_than_or_equal_to: 600 }
  validates :days, presence: true, :numericality =>  { greater_than: 1, less_than_or_equal_to: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/

  validates :dni, length: {maximum: 20}

  validates :email, format: { with: VALID_EMAIL_REGEX, message: "Wrong email format" },
                    allow_blank: true
  validates :phone_number, format: { with: VALID_PHONE_REGEX, message: "Wrong phone_number format" },
                           allow_blank: true
end