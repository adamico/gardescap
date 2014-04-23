module GardesHelper
  def link_to_create_or_destroy_garde(garde, date, time, period)
    ActionLink.new(garde, date, time, period, self).to_html
  end
end

class ActionLink
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include GardesHelper
  attr_accessor :context

  def initialize(garde, date, time, period, context)
    @garde  = garde
    @date   = date
    @time   = time
    @period = period
    @context = context
  end

  def to_html
    link_to icon, path, method: link_method, remote: true, class: "btn btn-xs btn-#{link_class}",
      data: dom_data, title: "#{title_prefix} garde - #{time_date}" if context.can?(action, Garde)
  end

  private

  def icon
    content_tag(:span, nil, class: "glyphicon glyphicon-#{icon_class}")
  end

  def path
    @garde ? context.garde_path(@garde) : context.gardes_path(garde: {date: @date, time: @time, period_id: @period.id, holiday: true})
  end

  def link_method
    @garde ? :delete : :post
  end

  def link_class
    @garde ? "danger" : "default"
  end

  def dom_data
    @garde ? { confirm: "Etes-vous sûr ?" } : nil
  end

  def title_prefix
    @garde ? "Détruire" : "Nouvelle"
  end

  def time_date
    "#{@time} - #{context.l(@date.to_date)}"
  end

  def action
    @garde ? :destroy : :create
  end

  def icon_class
    @garde ? "trash" : "plus"
  end
end
