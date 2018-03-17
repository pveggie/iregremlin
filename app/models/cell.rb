# frozen_string_literal: true

class Cell < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :puzzle
  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_validation :set_type

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def set_type
    case content
    when "empty" then self.content_type = "empty"
    when /ire/ then self.content_type = "ire"
    when /hill|tree/ then self.content_type = "obstacle"
    when /axe|sword|lance/ then self.content_type = "enemy"
    else raise "Change type"
    end
  end
end
