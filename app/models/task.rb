class Task < ActiveRecord::Base
  ## belongs_to は、「projectに所属している」ということ。
  ## rake db:migrate時に、自動で追加された。※但し、Project側にはなにも追加してくれないので、手動で追加すること。（has_manyなど）
  belongs_to :project

  # validationの定義 ★変更したらブラウザのreload必須！
  # ここでは titleが必須（＝空はダメ） ということを指定している
  # validates :title, presence: true    # デフォルトメッセージのままで良ければこれで
  validates :title,
  presence: { message: "タイトルを入力してください。" },   # 独自のメッセージを指定
  length: { minimum: 3, message: "タイトルの長さは3文字以上です。" }   # 日本語全角も1文字としてカウントされる

  scope :unfinished, -> { where(done: false) }
end
