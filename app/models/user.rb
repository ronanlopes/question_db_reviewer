class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_validation :set_role
  has_many :questions

  validates :name, presence: true

  def to_s
  	self.name
  end

  def set_role
  	self.role = Role.find_or_create_by(name: "Client") if !self.role
  end

  def admin?
  	self.role == Role.find_or_create_by(name: "Administrator")
  end

  def client?
  	self.role == Role.find_or_create_by(name: "Client")
  end


end
