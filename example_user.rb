#This file can be deleted. Just experimenting with classes

class User
  attr_accessor :name, :email

  def inititalize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} #{@email}"
  end
end
