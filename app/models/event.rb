class Event < ActiveRecord::Base
  before_validation :generate_token, on: :create
  has_many :attendances, dependent: :destroy
  has_many :registrations, dependent: :destroy

  before_validation :generate_token, on: :create
  validates :token, presence: true, uniqueness: true

  validates :name, presence: true
  validates :date, presence: true

  before_save :ensure_one_current

  def self.current
    find_by_current true
  end

  private
    def ensure_one_current
      if current_changed? && current?
        self.class.current.try(:update!, current: false)
      end
    end

    def generate_token
      self.token = Token.generate(2)
    end

    def list
    	@list ||= File.readlines('nouns.txt').each(&:strip!)
	end
end
