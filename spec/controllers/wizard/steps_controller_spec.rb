require 'rails_helper'

describe Wizard::StepsController do

  it 'needs you to be logged in' do
    expect {
      xhr :get, :index
    }.to raise_error(Discourse::NotLoggedIn)
  end

  it "raises an error if you aren't an admin" do
    log_in
    xhr :get, :index
    expect(response).to be_forbidden
  end

  context "as an admin" do
    before do
      log_in(:admin)
    end

    it "responds with the index" do
      xhr :get, :index
      expect(response).to be_success
    end

    it "raises an error with an invalid id" do
      xhr :put, :update, id: 'made-up-id', fields: { forum_title: "updated title" }
      expect(response).to_not be_success
    end

    it "updates properly if you are staff" do
      xhr :put, :update, id: 'forum-title', fields: { forum_title: "updated title" }
      expect(response).to be_success
      expect(SiteSetting.title).to eq("updated title")
    end
  end

end

