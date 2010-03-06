module SharesHelper
  def share_list_heading
    share_type = case controller.action_name
     when 'index' : 'most recent share'
     when 'popular' : 'popular share'
     when 'bin' : 'upcoming share'
    end
  "Showing #{pluralize(@shares.size, share_type) }"
  end
end
