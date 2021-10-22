module QuestionsHelper
  def choose_new_or_edit
      if action_name == 'new'
        confirm_questions_path
      elsif action_name == 'edit'
        question_path
      end
  end
end
