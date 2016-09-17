class Cell < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :row

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_validation :set_image, if: :image_missing?
  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def set_image
    self.image = content.blank? ? nil : "#{content}.jpg"
  end

  def image_missing?
    image.blank?
  end
end
