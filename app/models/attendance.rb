class Attendance < ActiveRecord::Base
  belongs_to :member, required: true
  belongs_to :event, required: true, touch: true

  after_create: :save_memberships

  private

  def save_memberships
    event.organizations.each do |o|
      Membership.find_or_create_by!(member: member, organization: o)
    end
  end
end
