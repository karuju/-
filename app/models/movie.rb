class Movie < ApplicationRecord
  validates :title, presence: true

  has_many :content, as: :contentable

  enum category: { アクション: 0, アドベンチャー: 1, SF・ファンタジー: 2, ホラー: 3, コメディ: 4, ロマンス: 5, ヒューマンドラマ: 6, ミュージカル: 7, ミステリー・サスペンス: 8, 歴史・伝記: 9, ドキュメンタリー: 10, スポーツ: 11, 戦争: 12, 西部劇: 13 }

  def self.ransackable_attributes(auth_object = nil)
    ["title", "director", "category"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["contents"]
  end

end
