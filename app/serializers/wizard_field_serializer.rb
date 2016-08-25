class WizardFieldSerializer < ApplicationSerializer
  OBJ_FIELDS = [:id,
                :type,
                :required,
                :value]

  attributes(*OBJ_FIELDS)
  attributes :label, :placeholder

  OBJ_FIELDS.each do |f|
    define_method(f) { object[f] }
    define_method("include_#{f}?") { object[f].present? }
  end

  def i18n_key
    @i18n_key ||= "wizard.step.#{object[:step_id]}.fields.#{id}".underscore
  end

  def label
    I18n.t("#{i18n_key}.label", default: '')
  end

  def include_label?
    label.present?
  end

  def placeholder
    I18n.t("#{i18n_key}.placeholder", default: '')
  end

  def include_placeholder?
    placeholder.present?
  end
end
