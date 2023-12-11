# Exercise 5

class LaunchDiscussionWorkflow
  def initialize(discussion, host, participants)
    @discussion = discussion
    @host = host
    @participants = participants
  end

  # Expects @participants array to be filled with User objects
  def run
    return unless valid?
    
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

  # ...

end

def create_test_users(email_addresses)
  email_addresses.uniq.map do |email_address|
    User.create(email: email_address.downcase, password: Devise.friendly_token)
  end
end

discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
participants = create_test_users(["fake1@example.come", "fake2@example.come", "fake3@example.com"])

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
workflow.run
