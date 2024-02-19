class Game < ApplicationRecord
  validates :title, presence: true

  has_many :content, as: :contentable

  enum category: { 恋愛: 0, ヒューマンドラマ: 1, サスペンス・ミステリー: 2, ホラー: 3, ギャグ・コメディー: 4, 職業・ビジネス: 5, 医療・病院系: 6, グルメ: 7, 歴史・時代劇: 8, アクション・アドベンチャー: 9, SF・ファンタジー: 10, ヤンキー・任侠: 11, ギャンブル: 12, スポーツ: 13 }

  def self.ransackable_attributes(auth_object = nil)
    %w[title category]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[contents]
  end
end
