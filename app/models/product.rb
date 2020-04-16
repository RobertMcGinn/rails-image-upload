class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  mount_uploader :avatar, AvatarUploader
  mount_uploader :image2, Image2Uploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :image_type
  after_update :crop_avatar, :crop_image2

  def crop_avatar
    avatar.recreate_versions! if crop_x.present? && image_type == 'avatar'
  end

  def crop_image2
    image2.recreate_versions! if crop_x.present? && image_type == 'image2'
  end
end