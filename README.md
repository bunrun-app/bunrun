# bunrun

## Quick Start

1. **Install Project**

   ```console
   $ git clone https://github.com/bunrun-app/bunrun
   ```

1. **Firebase Configuration File**

   Make sure the `GoogleService-Info.plist` file is in the target directory, as follows:

   ```sh
    bunrun/ # repo root
    ├─bunrun.xcodeproj/
    ├─bunrun/
    │ │ ... # other files
    │ └─GoogleService-Info.plist
    └─README.md
   ```

   > You can get the configuration file from the [Firebase Console](https://console.firebase.google.com/) under "Project Settings" > "General" > "Your Apps" > "SDK Setup and configuration".
   >
   > Do not share this file! Make sure to keep it in your local project directory **only**, and do not stage it when committing.

1. **Open in Xcode**

   ```console
   $ cd bunrun
   $ open bunrun.xcodeproj
   ```

1. **Build and Run**

   In Xcode, select a target device then click the "Run" button (or <kbd>Cmd</kbd> + <kbd>R</kbd>) to build and run the app.
