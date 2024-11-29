🎥 **Director Review App**
A Flutter-based application that allows users to review and comment on videos. The app supports default videos, YouTube video integration, and local file uploads. Users can play videos, add comments with timestamps, and search through the comments.
Features
Play a default video on app start.
Upload videos from local storage or add a YouTube video via a URL.
Switch seamlessly between default, YouTube, and local videos.
Add comments with timestamps (Director role).
Search comments by keywords.
Fully responsive design with a dark theme for better user experience.
Installation and Running the App
**Prerequisites**
Before running the app, ensure you have the following:

Flutter installed on your machine. If not, install Flutter here.
A code editor like Visual Studio Code or Android Studio.
Design Decisions
Default Video Integration:

A default video (FlickVideoPlayer) is preloaded to provide an immediate experience for the user without requiring a video upload.
Dynamic Video Switching:

**Users can easily switch between:**
A YouTube video by entering a valid URL.
A local video by uploading a file.
Controllers (VideoPlayerController and YoutubePlayerController) are dynamically initialized and disposed of to ensure smooth transitions.
Dark Themed UI:

The app uses a sleek dark theme (Color(0xFF121212)) for better visibility and a professional appearance.
Comments with Timestamps:

The Director can add comments with timestamps, making it easy to refer to specific moments in the video.
Responsive Layout:

The app uses SliverAppBar and responsive padding to ensure compatibility across various devices.
Search Functionality:

A search bar was added to help users quickly locate relevant comments.
User Experience:

Buttons for uploading videos or adding YouTube URLs are prominent and easy to use.
Error handling ensures invalid URLs or failed uploads are properly communicated to the user.

Here is the README.md file for your app:

bash
Copy code
git clone <repository-url>
cd <repository-directory>
Open the project folder in your preferred code editor.

Install Dependencies
Run the following command to install required dependencies:
bash
Copy code
flutter pub get
Run the App
Run the app using the following command:
bash
Copy code
flutter run
Make sure you have an emulator running or a physical device connected.
Design Decisions
Default Video Integration:

A default video (FlickVideoPlayer) is preloaded to provide an immediate experience for the user without requiring a video upload.
Dynamic Video Switching:

**Users can easily switch between:**
A YouTube video by entering a valid URL.
A local video by uploading a file.
Controllers (VideoPlayerController and YoutubePlayerController) are dynamically initialized and disposed of to ensure smooth transitions.
Dark Themed UI:

The app uses a sleek dark theme (Color(0xFF121212)) for better visibility and a professional appearance.
Comments with Timestamps:

The Director can add comments with timestamps, making it easy to refer to specific moments in the video.
Responsive Layout:

The app uses SliverAppBar and responsive padding to ensure compatibility across various devices.
Search Functionality:

A search bar was added to help users quickly locate relevant comments.
User Experience:

Buttons for uploading videos or adding YouTube URLs are prominent and easy to use.
Error handling ensures invalid URLs or failed uploads are properly communicated to the user.
How to Use
Default Video:

On app launch, a default video is played automatically.
Upload a Local Video:

Tap the upload icon (📁) in the top-right corner.
Select "Local File" and choose a video from your device.
Play a YouTube Video:

Tap the upload icon (📁) in the top-right corner.
Select "YouTube" and paste a valid YouTube video URL.
Add Comments:

Type your comment in the "Add a comment..." text field.
Press "Add Comment with Timestamp" to associate the comment with the current video timestamp.
Search Comments:

Use the search bar to find comments by keywords.

**Dependencies**
The app relies on the following Flutter packages:

flick_video_player: To play default and local videos with advanced controls.
video_player: Core video playback functionalities.
youtube_player_flutter: To integrate and play YouTube videos.
file_picker: To allow users to pick videos from local storage.

**Future Improvements**
Add support for more video formats and streaming services.
Provide different user roles (e.g., Director and Viewer) with unique permissions.
Enhance UI animations and transitions.
Include a database for saving and retrieving comments.



