module QuestionsHelper
  def choose_new_or_edit
    if action_name == 'new'
      confirm_questions_path
    elsif action_name == 'edit'
      question_path
    end
  end

  def time_ago_converter(date)
    during = DateTime.now.to_i - date.to_i
    if during/(60) == 0
      Time.at(during).utc.strftime("%S sec")
    elsif during/(60*60) == 0
      Time.at(during).utc.strftime("%M min")
    elsif during/(60*60*24) == 0
      Time.at(during).utc.strftime("%H hours")
    else
      Time.at(during).utc.strftime("%d days")
    end
  end

  def user_picture_is_mounted_or_no(user)
    if user.picture.class == String
      user.picture
    else
      user.picture.url
    end
  end
end
