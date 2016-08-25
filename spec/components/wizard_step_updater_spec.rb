require 'rails_helper'
require_dependency 'wizard_step_updater'

describe WizardStepUpdater do
  let(:user) { Fabricate(:admin) }

  it "can update the forum title" do
    updater = WizardStepUpdater.new(user, 'forum_title')
    updater.update(forum_title: 'new forum title')

    expect(updater.success?).to eq(true)
    expect(SiteSetting.title).to eq("new forum title")
  end
end
