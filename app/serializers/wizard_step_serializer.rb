class WizardStepSerializer < ApplicationSerializer

  OBJ_FIELDS = [:id,
                :next]

  attributes(*OBJ_FIELDS)
  attributes :description, :title

  has_many :fields, serializer: WizardFieldSerializer, embed: :objects

  OBJ_FIELDS.each do |f|
    define_method(f) { object[f] }
  end

  def i18n_key
    @i18n_key ||= "wizard.step.#{id}".underscore
  end

  def description
    I18n.t("#{i18n_key}.description", default: '')
  end

  def include_description?
    description.present?
  end

  def title
    I18n.t("#{i18n_key}.title", default: '')
  end

  def include_title?
    title.present?
  end

  def fields
    object[:fields]
  end
end

