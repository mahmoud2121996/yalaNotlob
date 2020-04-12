jQuery = require('jquery')
class Notifications {
    constructor() {
        this.handleClick = this.handleClick.bind(this);
        this.handleSuccess = this.handleSuccess.bind(this);
        this.notifications = $("[data-behavior='notifications']");

        if (this.notifications.length > 0) {
            this.handleSuccess(this.notifications.data("notifications"));
            $("[data-behavior='notifications-link']").on("click", this.handleClick);
            setInterval((() => {
                return this.getNewNotifications();
            }), 5000);
        }
    }

    getNewNotifications() {
        return $.ajax({
            url: "/notifications.json",
            dataType: "JSON",
            method: "GET",
            success: this.handleSuccess
        });
    }

    handleClick(e) {
        return $.ajax({
            url: "/notifications/mark_as_read",
            dataType: "JSON",
            method: "POST",
            success() {
                return $("[data-behavior='unread-count']").text(0);
            }
        });
    }

    handleSuccess(data) {
        const items = data.map(notification => "<h6>" + notification.content + "</h6>");

        let unread_count = 0;
        data.forEach((notification) => {
            if (!notification.read) {
                unread_count += 1;
            }
        });
        console.log(unread_count)
        $("[data-behavior='unread-count']").text(unread_count);
        return $("[data-behavior='notification-items']").html(items);
    }
}

jQuery(() => new Notifications);