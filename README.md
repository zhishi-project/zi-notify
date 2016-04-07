# Zhishi Notification System

As Zhishi is growing, there is a need for a notification system which ought to manage all things related to notifying a user.

The plan is to have a central system that would manage all kinds of Zhishi to users notification, which includes, but not limited to Email, Slack, WebSockets etc.

The system will receive a JSON payload either through a messaging protocol or through a HTTP protocol and would resolve which users should be notified and check the user's notification preferences to be sure if the users that needs to be notified want to be notified at this time and which medium they would prefer.

This makes the notification system a bit robust, non-disturbing and non-intrusive.

All notifications triggered by Zhishi would be handled here, however all notifications triggered by the user would be handled by the ZiBot.
