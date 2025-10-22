class User < ApplicationRecord
  has_secure_password

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_one :profile, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }
  validate :password_and_confirmation_match, if: -> { password.present? || password_confirmation.present? }

  # --- いいね機能 ---
  def like(tweet)
    likes.find_or_create_by(tweet_id: tweet.id)
  end

  def unlike(tweet)
    likes.where(tweet_id: tweet.id).destroy_all
  end

  def liked?(tweet)
    liked_tweets.exists?(tweet.id)
  end

  private

  def password_and_confirmation_match
    if password.strip.empty?
      errors.add(:password, 'を入力してください')
    end
    if password != password_confirmation
      errors.add(:password_confirmation, 'とパスワードが一致しません')
    end
  end
end
