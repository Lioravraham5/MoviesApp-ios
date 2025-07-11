# 🎬 Movie Mood

Movie Mood is a sleek and intuitive iOS application that helps users discover, explore, and track their favorite movies. Powered by the [TMDB API](https://www.themoviedb.org/documentation/api), the app provides categorized movie browsing, detailed movie information, and personal watchlist management — all wrapped in a beautiful user experience with light and dark mode support.

## 📱 Features

- ✅ **Movie Discovery**  
  Browse movies by popularity, top ratings, upcoming releases, and genres like Action, Comedy, Drama, Horror, and more.

- 🔍 **Movie Details**  
  View comprehensive movie details including runtime, release date, overview, genres, and rating.

- 💾 **Watchlist Management with Firestore**  
  Authenticated users can save their favorite movies to a personal watchlist using Firebase Firestore, ensuring persistent storage across devices.

- 🔐 **User Authentication with Firebase**  
  Secure login and registration using Firebase Authentication, managing each user’s personal data and watchlist.

- 🎥 **TMDB API Integration**  
  Movie content is dynamically fetched from TMDB’s public API, ensuring up-to-date and accurate information.

- 💡 **Dark & Light Mode Support**  
  Automatically adapts to the device’s appearance settings for an optimal viewing experience.

- 📐 **Portrait and Landscape Support**  
  Supports both portrait and landscape orientations across all screens.

- 🧱 **Clean MVC Architecture**  
  Follows Apple’s Model-View-Controller pattern for organized, scalable, and maintainable code.

## 🧰 Technology Stack

| Layer             | Technology                    |
|------------------|-------------------------------|
| UI & UX          | UIKit, Storyboard, Auto Layout|
| Architecture     | MVC                           |
| Backend Services | Firebase Auth + Firestore     |
| API              | TMDB API                      |
| Image Loading    | URLSession / Custom Utility   |
| Language         | Swift                         |
| iOS Version      | iOS 15+                        |


## 🔐 Firebase Features

- **Authentication:**  
  User registration and login via email and password using Firebase Authentication.
- **Firestore Database:**  
  Personal watchlist storage per user

 ## 📄 License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## 👩‍💻 Developed By
**Lior Avraham**
iOS Developer · Passionate about clean code, cinematic design, and building amazing user experiences

## 🙏 Acknowledgments
- [TMDB - The Movie Database](https://www.themoviedb.org/documentation/api) for the open movie API
- [Firebase](https://firebase.google.com/) for seamless backend services
