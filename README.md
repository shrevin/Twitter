# Project 2 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **50** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at latest the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [ ] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [x] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (140 characters) (**1 point**)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [ ] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:
- adding circular profiles to mimic Twitter's UI
- adding borders to pictures
- not letting users post their tweet if the character count is over 140 characters

List anything else that you can get done to improve the app functionality!
- viewing the profile page of users
- adding a timeline on the bottom
- implementing hyperlinks and images in tweets

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to figure out how to get clearer profile images.
2. I want to also further explore the concept of delegates and how they are used.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![](https://github.com/shrevin/Twitter/blob/main/final.gif)

Refreshing the timeline, replying to tweets, unfavoriting, and unretweeting:

![](https://github.com/shrevin/Twitter/blob/main/ezgif.com-gif-maker.gif)

Autolayout Image 1
![alt text](https://github.com/shrevin/Twitter/blob/main/autolayout%20image%201.png)

Autolayout Image 2
![alt text](https://github.com/shrevin/Twitter/blob/main/autolayout%20image%202.png)

GIF created with [Kap](https://getkap.co/).

## Notes
Describe any challenges encountered while building the app.


I had trouble figuring how to implement a POST request and understanding the components of the method. Specifically, I had trouble figuring out the API call for replying to a tweet. Another challenge was figuring out how to access the super view of a button which was necessary for replying to a tweet since the sender for this functionality is not a table view cell. Furthermore, I initially struggled with autolayout but understood it better after watching a few videos. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
