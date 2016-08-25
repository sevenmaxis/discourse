import { observes } from 'ember-addons/ember-computed-decorators';

export default Ember.Component.extend({
  classNames: ['wizard-step'],
  saving: null,

  didInsertElement() {
    this._super();
    this.autoFocus();
  },

  @observes('step.id')
  _stepChanged() {
    this.set('saving', false);
    this.autoFocus();
  },

  keyPress(key) {
    if (key.keyCode === 13) {
      this.send('nextStep');
    }
  },

  autoFocus() {
    Ember.run.scheduleOnce('afterRender', () => {
      const $invalid = $('.wizard-field.invalid:eq(0) input');

      if ($invalid.length) {
        return $invalid.focus();
      }

      $('input:eq(0)').focus();
    });
  },

  saveStep() {
    const step = this.get('step');
    step.save()
      .then(() => this.sendAction('goNext'))
      .catch(response => {
        const errors = response.responseJSON.errors;
        if (errors && errors.length) {
          errors.forEach(err => {
            step.fieldError(err.field, err.description);
          });
        }
      });
  },

  actions: {
    nextStep() {
      if (this.get('saving')) { return; }

      const step = this.get('step');
      step.checkFields();

      if (step.get('valid')) {
        this.set('saving', true);
        step.save()
          .then(() => this.sendAction('goNext'))
          .catch(() => null) // we can swallow because the form is already marked as invalid
          .finally(() => this.set('saving', false));
      } else {
        this.autoFocus();
      }
    }
  }
});
