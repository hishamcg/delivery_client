class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def self.authenticate(params)
    if params[:phone].present?
      check_user_db = User.where(:phone => params[:phone]).first.presence
      if check_user_db.present?
        data_array = User.where(:phone => params[:phone]).first.presence
        return data_array
      else
        mxr = DeliveryCrossReference.find_by_phone(params[:phone])
        if mxr.present?
          data_array = create_new_user(params[:phone],mxr.delivery_person)
          return data_array
        end
      end
      # mxr = DeliveryCrossReference.find_by_phone(params[:phone])
      # if mxr.present?
      #   data_array = {:user_data => (User.where(:phone => params[:phone]).first.presence || create_new_user(params[:phone],mxr))}
      #   return data_array
      # end
    end
    false
  end

  def self.send_otp

  end
  def self.create_new_user(phone,mxr)
    user = User.new
    user.email = "#{phone}@strata.com"
    user.phone = phone
    user.password = "ilovedelivering"
    user.name = mxr.name
    user.cluster_id = mxr.cluster_id
    user.delivery_person_id = mxr.id
    user.save
    user
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
