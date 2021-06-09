class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  MICROPOSTS_PERMIT = %i(content image).freeze

  scope :order_post, -> { order created_at: :desc }

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.validates.content_size}
  validates :image, content_type: { in: Settings.micropost.img_file, message: I18n.t("micropost.image.message") },
    size: { less_than: Settings.users_micropost.megabytes, message: I18n.t("micropost.image.size") }

  def display_image
    image.variant(resize_to_limit: [Settings.micropost.size_img, Settings.micropost.size_img])
  end
end
