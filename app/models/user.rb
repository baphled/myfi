class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::Timestamps

  field :email
  field :password_digest, :type => String
  has_secure_password
end
