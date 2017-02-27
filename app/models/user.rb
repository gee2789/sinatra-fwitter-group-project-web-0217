class User < ActiveRecord::Base
  has_many :tweets

  include Slug::InstanceMethods
  extend Slug::ClassMethods

  def authenticate(password)
    if self.password==password.to_s
      self
    else
      false
    end
  end

end
