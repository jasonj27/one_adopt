(function() {
    var Notifications,
        __bind = function(fn, me) { return function() { return fn.apply(me, arguments); }; };

    Notifications = (function() {
        function Notifications() {
            this.handleSuccess = __bind(this.handleSuccess, this);
            this.notifications = $("[data-behavior='notifications']");
            if (this.notifications.length > 0) {
                this.setup();
                this.handleSuccess(this.notifications.data("notifications"));
                $("[data-behavior='notifications-link']").on("click", this.handleClick);
            }
        }

        Notifications.prototype.setup = function() {
            return $.ajax({
                url: "/notifications.json",
                dataType: "JSON",
                method: "GET",
                success: this.handleSuccess
            });
        };

        Notifications.prototype.handleClick = function(e) {
            return $.ajax({
                url: "/notifications/mark_as_read",
                dataType: "JSON",
                method: "POST",
                success: function() {
                    return $("[data-behavior='unread-count']").text('0');
                }
            });
        };

        Notifications.prototype.handleSuccess = function(data) {
            for (let i of data.notifications) {
                console.log(i);
                $("#div1").append(`<a href="${i.url}" class="dropdown-item">${i.actor}發送新訊息給你</a>`);
            }
            $("[data-behavior='unread-count']").text(data.unread_count)
        };

        return Notifications;

    })();

    $(function() {
        return new Notifications;
    });

}).call(this);