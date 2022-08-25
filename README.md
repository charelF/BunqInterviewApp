# Bunq Interview App

Simple Payments App I developed for the Bunq iOS developer interview take-home assignment. The App is developed in SwiftUI, using XCode 13.4.1 and targets iOS 15.5.

## Features :

> - Do a payment
> - See a payment overview
> - See details for a payment

The app supports all of these features

> Do this while storing the payments in a local database. Although
make sure that this behaves more like a network call. Where reading
and writing to the database will both be delayed by a second and
any call can fail 1 in 10 times where it will throw an exception after
the delay.

I used Core Data for the database. I used `async` and added delays such that the UI is responsive at all times, even though the request may fail or not and takes always 1 second to load.

## Gif

| All features |
| --- |
| <img src="https://user-images.githubusercontent.com/29770094/186629362-fcfcb521-2d8e-4770-a1fa-3ed4997ee4f7.gif" width="250"> |

## Images

| Payment screen | Sending | Success | Payments history | Dark Theme |
| --- | --- | -- | -- |  -- |
| ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 15 48](https://user-images.githubusercontent.com/29770094/186629153-2f069a33-9893-495f-af06-5e1f842d4b79.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 16 34](https://user-images.githubusercontent.com/29770094/186629188-c5555b49-2058-4952-b3fa-a93c551fa644.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 16 35](https://user-images.githubusercontent.com/29770094/186629195-cb669ccc-046f-4b36-840c-81fe1e2c7341.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 18 11](https://user-images.githubusercontent.com/29770094/186629353-8d035881-7901-4208-b250-8a921c753532.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 11 15 17](https://user-images.githubusercontent.com/29770094/186629356-1eddf36c-8f15-4adf-8a34-abfc7289bae0.png) |

| Initial Network fetching | Payments history | Detail view | Failed network connection | Dark Theme |
| --- | --- | -- | -- | -- |
| ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 17 12](https://user-images.githubusercontent.com/29770094/186629349-df65a9b7-b387-41e6-af9c-44e79536af55.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 16 53](https://user-images.githubusercontent.com/29770094/186629329-ea635d96-09b5-4409-9589-ea1fc010c78d.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 16 47](https://user-images.githubusercontent.com/29770094/186629326-df7483fa-8925-4a7d-8bd2-a34274379ff9.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 10 17 07](https://user-images.githubusercontent.com/29770094/186629335-3b7575c4-b80d-49e6-bcb9-0ae846b3a9a9.png) | ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-25 at 11 15 20](https://user-images.githubusercontent.com/29770094/186629360-4bc9e9b1-2e0c-4806-a078-2584a2d04787.png) |
