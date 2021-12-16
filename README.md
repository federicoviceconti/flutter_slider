# flutter_slider
Creates slides from a json file. This tool will show a presentation that adapts to every screen resolution.
You can find some presentation examples into "assets/json" folder.

## Why?
To make speeches special. This project was created to show the powerful of Flutter framework.

*Update Nov 2020*:
- State management presentation
- Included speech for the Sapienza's University
- Integrated some features on widgets like: opening link, adding shapes etc.

## Flutter State Management - Tech corner
A tech corner is a 30 minutes speech, where we talk about everything such as: trend technologies, soft skills and much more.
In this event we try to explain the state management topic for the Flutter framework.

## Why Flutter works! - Sapienza
Explaing why Flutter rocks using real examples made in Flutter.
Link: https://sapienza-slides.web.app/

# How code is structured?
In core folder you can find: BaseWidget and BaseNotifier. 
Every widgets contains the BaseWidget, and every notifier extends from the BaseNotifier.
The Api class contains the interaction with a mock json assets (by you can switch environment to interact with an external server).

# Where can I find slides example?
In the following path, you can find slide example: *flutter_slider/assets/json/*. 
To run local assets, switch *environment* to mock.

Have a good day! :)
