module NonprofitsHelper

  def can_manage?(nonprofit)
    nonprofit.user == current_user
  end

  def certified?(nonprofit)
    if nonprofit.certified
      content_tag(:span, nil, class: 'glyphicon glyphicon-check', title: 'Certified')
    else
      content_tag(:span, nil, class: 'glyphicon glyphicon-unchecked', title: 'Not certified')
    end
  end
end
