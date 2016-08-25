import Step from 'wizard/models/step';
import WizardField from 'wizard/models/wizard-field';

import { ajax } from 'wizard/lib/ajax';

export default Ember.Route.extend({
  model() {
    return ajax({ url: '/wizard/steps.json' }).then(response => {
      const wizard = response.wizard;
      wizard.steps = wizard.steps.map(step => {
        const stepObj = Step.create(step);
        stepObj.fields = stepObj.fields.map(f => WizardField.create(f));
        return stepObj;
      });

      return wizard;
    });
  }
});
