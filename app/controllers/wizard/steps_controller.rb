require_dependency 'wizard_step_updater'

class Wizard::StepsController < ApplicationController

  before_filter :ensure_logged_in
  before_filter :ensure_staff

  def index

    wizard = {
      start: 'forum-title',
      steps: [
        {
          id: 'forum-title',
          fields: [
            { id: 'forum_title', type: 'text', required: true, value: SiteSetting.title }
          ],
          next: 'contact'
        },
        {
          id: 'contact',
          fields: [
            { id: 'contact_email', type: 'text', required: true }
          ],
        }
      ]
    }

    wizard[:steps].each do |step|
      step[:fields].each do |f|
        f[:step_id] = step[:id]
      end
    end

    render_serialized(wizard, WizardSerializer)
  end

  def update
    updater = WizardStepUpdater.new(current_user, params[:id])
    updater.update(params[:fields])
    render nothing: true
  end

end
