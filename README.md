# WeatherApp

<h1><b>Instructions</b></h1>
This is a weather Apps using World Weather Online API(https://www.worldweatheronline.com/developer/api/docs/) for users to search for cities name, upon typing in the SearchTextFIeld, user will be able to see a list of available cities that pattern matches on what user have typed. There will be two sections, one is for recently viewed cities that is stored locally and displaying the cities in alphabetically order.

Compatible with any iPhone/iPad devices. 

<h2><b>How to test the app?</b></h2>
Download and unzip the project, then run it on Xcode by double clicking *WeatherApp.xcodeproj*. 

On the navigation bar, top left is the delete button where user are able to clear all the recently viewed cities. 

On the navigation bar, middle is the searchTextField where user are able to search the matching cities name.

On the navigation bar, top right is the search button

Tap on the listed city upon searches, you will be routed to the city detailed view screen.

<h2><b>Features</b></h2>
1) Able to search for city name and will be displaying list of avalable cities that pattern matches on what user typed.
2) User able to tap on the particular city name and will be routed to the detailed view showing the weatherImage, humidity, temperature and weather description
3) There will be an empty state view when the user have not viewed any City's weather before
4) If user have viewed any city's weather before, under Recently Viewed section, user will be able to see a ordered list of the recent 10 cities that the user recently viewed in alphabetically order.
5) Given that if the user terminate the app(relaunch the app), the user will still be able to see the ordered list of the recent 10 cities that the user previously seen.

Select any iPhone or iPad simulator.

iPhone <br>
<image src = "Images/empty%20state.png" width="150" height="300">
<image src = "Images/search%20city.png" width="150" height="300">
<image src = "Images/city%20detail%20view.png" width="150" height="300">
<image src = "Images/deletion.png" width="150" height="300">
<image src = "Images/10%20viewed%20city.png" width="150" height="300">
