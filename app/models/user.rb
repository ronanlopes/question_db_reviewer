class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_validation :set_role

  validates :name, presence: true


  def set_role
  	self.role = Role.find_or_create_by(name: "Client") if !self.role
  end

end
