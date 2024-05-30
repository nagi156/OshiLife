module Public::NotificationsHelper
  def transition_path(notification)
    case notificaton.action_type.to_sym
    when :commented_to_own_post
      post_path(notification.subject.post, anchor: "comment-#{notification.subject.id}")
    when :liked_to_own_post
      post_path(notification.subject.post)
    when :followed_me
      user_path(notification.subject.following)
    end
  end
end
