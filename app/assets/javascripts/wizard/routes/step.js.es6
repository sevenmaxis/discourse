export default Ember.Route.extend({
  model(params) {
    const allSteps = this.modelFor('application').steps;
    return allSteps.findProperty('id', params.step_id);
  },

  setupController(controller, model) {
    controller.set('step', model);
  }
});
