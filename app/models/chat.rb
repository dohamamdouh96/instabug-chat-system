class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :application, counter_cache: true, :autosave => true

  validates_uniqueness_of :number
  validates :number, presence: true, numericality: { more_than_or_equal_to: 1,  only_integer: true }

  def as_json(options = {})
    super(options.merge({ except: [
      :id,
      :application_id
    ], :include => {
      :application => {:only => [:token]}
    }}))   
  end

  after_save :index_messages_in_elasticsearch

  private

  def index_messages_in_elasticsearch
    messages.__elasticsearch__.create_index!(force: true)
    messages.find_each { |message| message.__elasticsearch__.index_document }
  end


end
