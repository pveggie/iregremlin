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
  before_create :calculate_enemies
  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  private
  def calculate_enemies
    self.enemies = cells.select { |cell| cell.content_type == "enemy" }.count
  end
end

