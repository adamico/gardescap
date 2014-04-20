class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gardes, through: :assignments
  has_many :assignments, dependent: :destroy

  def to_s
    name
  end

  def has_already_chosen?(garde)
    assignments.where(garde: garde, user: self).any?
  end
end
