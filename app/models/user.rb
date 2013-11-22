class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me 
  attr_accessible :username, :first_name, :last_name
  # attr_accessible :title, :body

  has_one :wallet


  # Validate Username
  validate :any_username?
  def any_username?
    if %w(username).all?{|attr| self[attr].blank?}
      errors.add :base, ("Invalid Username")
    end
  end
end
