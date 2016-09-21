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
  before_validation :set_type

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def set_image
    self.image = content.blank? ? nil : "#{content}.jpg"
  end

  def set_type
    if content.blank?
      self.content_type = "empty"
    elsif content == "ire"
      self.content_type = "ire"
    elsif content == "hill" || content == "tree"
      self.content_type = "obstacle"
    else
      self.content_type = "enemy"
    end
  end

  def image_missing?
    image.blank?
  end
end
