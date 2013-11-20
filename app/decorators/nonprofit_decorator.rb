module NonprofitDecorator
  def category_name
    category.try(:name)
  end

  def tags
    super.map(&:name).join ', '
  end

  def certified?
    if self.certified
      content_tag(:span, nil, class: 'glyphicon glyphicon-check', title: 'Certified')
    else
      content_tag(:span, nil, class: 'glyphicon glyphicon-uncheck', title: 'Not certified')
    end
  end
end
