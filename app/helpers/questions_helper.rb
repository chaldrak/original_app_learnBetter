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
      Time.at(during).utc.strftime("%H heures")
    elsif during/(60*60*24*30) == 0
      Time.at(during).utc.strftime("%d jours")
    else
      Time.at(during).utc.strftime("%m mois")
    end
  end

  def day_ago_converter(date)
    created_date = date.to_date
    if created_date == Date.today
      "aujourd'hui"
    elsif created_date == Date.yesterday
      'hier'
    elsif Date.today - created_date > (1/1)
      created_date.strftime("%F")
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
