class Project < ActiveRecord::Base

  # Taskを1対多で所持する ※これは手で記入した。Task側の belongs_to は rake db:migrate で自動追加される。
  has_many :tasks
  
  # validationの定義 ★変更したらブラウザのreload必須！
  # ここでは titleが必須（＝空はダメ） ということを指定している
  # validates :title, presence: true    # デフォルトメッセージのままで良ければこれで
  validates :title,
  presence: { message: "タイトルを入力してください。" },   # 独自のメッセージを指定
  length: { minimum: 3, message: "タイトルの長さは3文字以上です。" }   # 日本語全角も1文字としてカウントされる

end
