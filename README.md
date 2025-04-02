CatTinder

CatTinder is a playful mobile application that allows users to browse cat images, like their favorites, and manage a list of liked cats. The app mimics a Tinder-style swipe mechanism for an engaging user experience.

Features

Swipe to Like: Users can swipe through cat images and like/dislike them.

Saved Favorites: Liked cats are stored for later viewing.

Smooth Image Loading: Uses caching for efficient image display.

Firebase Integration: Supports backend services like authentication or storage.

Technologies Used

SwiftUI: Modern UI framework for building the application.

Firebase: Backend support for authentication and data storage.

AsyncImage & Caching: Ensures smooth image loading and performance optimization.

MVVM Architecture: Separates business logic from the UI for better maintainability.

Project Structure

CatTinderApp.swift - Entry point of the app.

ViewModel/ - Handles business logic and state management.

Model/ - Defines data structures like Cat models.

Views/ - UI components for displaying cat images and user interactions.

ImageLoader.swift & CachedAsyncImage.swift - Efficient image handling and caching.

GoogleService-Info.plist - Firebase configuration file.

Assets.xcassets - Contains images and icons used in the app.

Installation

Clone the repository:

git clone https://github.com/yourusername/CatTinder.git

Open the project in Xcode.

Ensure you have Firebase configured if backend features are needed.

Run the project on a simulator or device.

Future Improvements

Implement user authentication.

Add more advanced filtering for cat breeds.

Improve UI animations and transitions.

