# flutter_slider
Creates simple flutter slides with a .json file, which adapts to every resolution.
You can find all the presentations into "assets/json" folder.

## Why?
This project is created for our flutter tech corner, which we explain flutter patterns for state management such as: BLoC or Provider.
To make this speech special, we show the power of provider flutter, making this presentation with Flutter.

*Update Nov 2020*: 
- We includes another presentation for "Sapienza"
- I integrated some features on widgets like: opening link, adding shapes etc.

## Flutter State Management - Tech corner
A tech corner is a 30 minutes speech, where we talk about everything, such as trend technologies, soft skills and much more.
In this event we try to explain the state management topic

## Why Flutter works! - Sapienza
Explaing why Flutter rocks using real examples made in Flutter
Link: https://sapienza-slides.web.app/

# How code is structured?
In core folder you can find: BaseWidget and BaseNotifier. 
Every widgets extends from BaseWidget, and every model extends the BaseNotifier.
The Api class contains the interaction with a mock server.

# Where can I find slides example?
In the following path, you can find slide example: *flutter_slider/assets/json/*. 
To run local assets, switch *environment* to mock.

Have a good day! :)
