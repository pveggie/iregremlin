# frozen_string_literal: true

class Puzzle < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  has_many :cells, dependent: :destroy
  # == Validations ==========================================================

  # == Scopes ===============================================================
  # only after finding a puzzle
  def rows
     cells
      .select('cells.id', :row_number, :column_number, :content, :content_type)
      .group_by { |cell| cell[:row_number] }
      .map { |array| array[1] }
  end

  # == Callbacks ============================================================
  after_validation :calculate_enemies, on: [:create]
  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  private
  def calculate_enemies
    self.enemies = cells.select { |cell| cell.content_type == "enemy" }.count
  end
end

