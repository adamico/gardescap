module GardesHelper
  def form_to_toggle_garde_state(garde)
    GardeForm.new(garde, self).to_html if can?(:update, garde)
  end

  def link_to_mass_toggle_holiday(date)
    link_to(content_tag(:span, nil, class: "glyphicon glyphicon-calendar"),
            mass_toggle_holiday_gardes_path(date: date), method: :patch, remote: true,
            class: "btn btn-default btn-xs")
  end
end

class GardeForm
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include GardesHelper
  attr_accessor :context

  def initialize(garde, context)
    @garde   = garde
    @context = context
  end

  def to_html
    context.form_for @garde, role: 'form', remote: true do |f|
      f.hidden_field(:state, value: field_value) +
      context.button_tag(type: :submit, class: 'btn btn-xs btn-default', id: "toggle-state-#{@garde.time}-#{@garde.date}", titre: titre) do
        icon
      end
    end
  end

  private

  def field_value
    @garde.active? ? 'inactive' : 'active'
  end

  def titre
    "Rendre #{field_value} garde - #{time_date}"
  end

  def time_date
    "#{@garde.time} - #{context.l(@garde.date.to_date)}"
  end

  def icon
    content_tag(:span, nil, class: "glyphicon glyphicon-#{icon_class}")
  end

  def icon_class
    @garde.active? ? 'star-empty' : 'star'
  end
end
