# cross-clean-ios

## iOS Architecture Example:

This should be a simple app, doing only the bare minimum for displaying data while still to adhearing to your architecture of choice (as if it were in production). This app will have two `UIViewControllers` / `Views`. The first view will be a list of all the users that will be returned from a specifc endpoint and filtered by their email, and the second will be a detail view for that user, which shows a list of all of their posts, which are to be fetched from a second endpoint via the user's ID.

### Reqiurements:
Each example app should:
- Get all users from https://jsonplaceholder.typicode.com/users
- Display 3 attributes from each user that has a `.biz` email in a each row of a table
    - company and street
        - `Business on Street`
    - their phone with all non-numeric characters filterd out
        - `01.612.823.6077 #1234`  ->  `0161282360771234`
    - their name & username
        - `someName & someUserName`
- Show user detail view on row tap
    - Display posts from user via their userId in detail view from endpoint https://jsonplaceholder.typicode.com/posts?userId=1
        - Post `title`
        - Post `body`

## Cross-CLEAN Architecture

![alt text](cross_clean_architecture.png "Cross-CLEAN")
