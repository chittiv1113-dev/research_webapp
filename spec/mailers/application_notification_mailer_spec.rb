require "rails_helper"

RSpec.describe ApplicationNotificationMailer, type: :mailer do
  describe "submit_application" do
    let(:mail) { ApplicationNotificationMailer.submit_application }

    it "renders the headers" do
      expect(mail.subject).to eq("Submit application")
      expect(mail.to).to eq([ "to@example.org" ])
      expect(mail.from).to eq([ "from@example.com" ])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
