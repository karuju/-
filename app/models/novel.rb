class Novel < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  has_many :content, as: :contentable
  enum category: { 恋愛: 0, ヒューマンドラマ: 1, サスペンス・ミステリー: 2, ホラー: 3, ギャグ・コメディー: 4, SF・ファンタジー: 5, 職業・ビジネス: 6, 医療・病院系: 7, グルメ: 8, 歴史・時代劇: 9, 政治: 10,  ライトノベル: 11, 児童文学: 12 }

  def self.ransackable_attributes(auth_object = nil)
    %w[title author category]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[contents]
  end
end
