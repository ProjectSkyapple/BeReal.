# Project 5 - *BeReal. Clone*

Submitted by: **Aaron Jacob**

**BeReal. Clone** is an app that is a clone of the main functionality of the popular anti-social media app **BeReal.** This clone allows users to create an account and log in with one to 
use the app. Users can view and post BeReal.

Time spent: **7** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can register a new account
- [x] User can log in with newly created account
- [x] App has a feed of posts when user logs in
- [x] User can upload a new post which takes in a picture from photo library and a caption	
 
The following **optional** features are implemented:

- [x] Users can pull to refresh their feed and see a loading indicator
- [ ] Users can infinite-scroll in their feed to see past the 10 most recent photos
- [x] Users can see location and time of photo upload in the feed	
- [x] User is able to logout
- [x] User stays logged in when app is closed and open again	

## Video Walkthrough

Here's a walkthrough of implemented user stories:

[Imgur](https://imgur.com/Yn9rxqw)

GIF created with [Kap](https://getkap.co/) for macOS.

## Notes

The most prominent challenge I encountered while developing the app was getting the `assetIdentifier`s of a selected photo's `PHAsset` when a user selects an image from the `PHPicker` while creating a post.
The `assetIdentifier`s would always be `nil`.
However, I figured out that my `PHPickerConfiguration` instance's `photoLibrary` property was not initialized to `PHPhotoLibrary.shared()`. This had to be done so the `assetIdentifier`s would not be `nil`.

## License

    Copyright 2023 Aaron Jacob

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
