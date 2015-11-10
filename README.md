# Concierge Growth App

Concierge Growth App is a feature that has the following steps:
* Login with Google
* Rate meeting with "Bob"
* User is thanked for submitting. If rating is 4 or 5, user is displayed a custom invite link.
* New users that visit the link are displayed a custom invitation with the name of the referrer. The new user can sign up on that page.
[Prototype](https://concierge-growth-app.herokuapp.com/)

The success of this feature is tested with a custom built analytics dashboard.
Key metrics include:
* Unique Rating Submissions Per Rating Page View (%)
* Rated 4 or 5 (%)
* Invite Page Views Per Link (%)
* Sign Ups Per Invite Page View (%)
[Analytics Dashboard](https://concierge-growth-app.herokuapp.com/admin)

It built on a Rails backend with a Postgres database and a Backbone.js front end. Google OAuth 2.0 and Chartkick are used for login and data visualization, respectively.

Please refer to the Gemfile for a comprehensive list of gems used.
