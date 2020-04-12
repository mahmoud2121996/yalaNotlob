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
            }), 1000);
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

    timeSince(date) {

        var seconds = Math.floor((new Date() - new Date(date)) / 1000);
        var interval = Math.floor(seconds / 31557600);
        if (interval >= 1) {
            return interval + " years ago";
        }
        interval = Math.floor(seconds / 2592000);
        if (interval >= 1) {
            return interval + " months ago";
        }
        interval = Math.floor(seconds / 86400);
        if (interval >= 1) {
            return interval + " days ago";
        }
        interval = Math.floor(seconds / 3600);
        if (interval >= 1) {
            return interval + " hours ago";
        }
        interval = Math.floor(seconds / 60);
        if (interval >= 1) {
            return interval + " minutes ago";
        }
        return "Less than a min ago";
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

    formatNotification(notification) {
        return (
            "<div class='notif'>" +
            "<img src='" + notification.img + "' />" +
            "<p>" + notification.content + "</p>" +
            "<p class='notif-time'>" + this.timeSince(notification.at) + "</p>" +
            "</div>" + "<hr>"
        )

    }

    footer = "<div class='notif-footer'><a href='/all_notifications.html'>Show all notifications</a></div>"

    handleSuccess(data) {
        const items = data.map(notification => this.formatNotification(notification));
        let unread_count = 0;
        data.forEach((notification) => {
            if (!notification.read) {
                unread_count += 1;
            }
        });
        $("[data-behavior='unread-count']").text(unread_count);
        if (items.length === 0) return $("[data-behavior='notification-items']").html("No new notifications")
        else {
            items.push(this.footer)
            return $("[data-behavior='notification-items']").html(items);
        }
    }
}

jQuery(() => new Notifications);