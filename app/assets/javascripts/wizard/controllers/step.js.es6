export default Ember.Controller.extend({
  step: null,

  actions: {
    goNext() {
      this.transitionToRoute('step', this.get('step.next'));
    }
  }
});
