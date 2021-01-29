class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true, :autosave => true

  validates_presence_of :body
  validates_uniqueness_of :number
  validates :number, presence: true, numericality: { more_than_or_equal_to: 1,  only_integer: true }

  def as_json(options = {})
    super(options.merge({ except: [
      :id,
      :chat_id
    ], :include => {
      :chat => {:only => [:number]}
    }}))   
  end
end
