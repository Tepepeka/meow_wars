class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  after_create :welcome_send

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likeables, dependent: :destroy
  has_many :liked_products,through: :likeables, source: :product

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def name
    email.split("@").first.capitalize
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def liked?(product)
    liked_products.include?(product)
  end

  def like(product)
    if liked_products.include?(product)
      liked_products.destroy(product)
    else
      liked_products << product
    end
    public_target = "product_#{product.id}_public_likes"
    broadcast_replace_later_to 'public_likes',
                                target: public_target,
                                partial:'likes/like_count',
                                locals: {product: product}
  end

  
end