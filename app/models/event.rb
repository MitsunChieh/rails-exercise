class Event < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :category

  has_one :location # 單數

  has_many :attendees # 複數

  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  def category_name
    category.try(:name)
  end

  belongs_to :user
  delegate :name, :to => :category, :prefix => true, :allow_nil => true

end