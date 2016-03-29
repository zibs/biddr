class Auction < ActiveRecord::Base
  include AASM
  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :details, presence: true
  validates :reserve_price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validate  :future_due_date

  aasm whiny_transitions: false do
     # Campaign.all.map(&:save) to make all be updated as draft
    state :draft, initial: true
    state :published
    state :reserve_met
    state :reserve_not_met
    state :won
    state :cancelled
     # events are used to transition from one state to another.
     # verbs are used as events as they `do` things
    event :publish do
     transitions from: :draft, to: :published
    end

    event :meets_reserve do
      transitions from: :published, to: :reserve_met
    end

    event :won do
      transitions from: :reserve_met, to: :won
    end

    event :doesnt_meet_reserve do
      transitions from: :published, to: :reserve_not_met
    end

    event :cancel do
      transitions from: [:draft, :published, :reserve_met], to: :cancelled
    end
   end

   def published
     where(aasm_state: :published)
   end

   private

    def future_due_date
      if self.ends_on
      self.ends_on > Date.yesterday ? true : errors.add(:due_date, "must be in the future!")
      end
    end

end
