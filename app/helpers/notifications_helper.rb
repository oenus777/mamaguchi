module NotificationsHelper
    def notification_form(notification)
      @visiter = notification.visiter
      @visiter_comment = notification.comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
            tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "like" then
            tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a(notification.post.title, href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
        when "comment" then
            tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a(notification.post.title, href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
      end
    end
    
    def unchecked_notifications
        @notifications = current_user.passive_notifications.where(checked: false)
    end
end
