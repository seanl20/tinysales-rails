module SidenavHelper
  def link_active?(link_name)
    if controller_name == link_name
      "bg-gray-50 text-indigo-600 font-semibold"
    else
      "text-gray-700 hover:text-indigo-600 hover:bg-gray-50"
    end
  end

  def icon_active?(link_name)
    if controller_name == link_name
      "text-indigo-600"
    else
      "text-gray-400 group group-hover:text-indigo-600"
    end
  end
end
