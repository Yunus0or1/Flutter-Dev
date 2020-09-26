# Flutter_Dev

1. A basic Flutter application implementing **Reactive and SingleTon** Design pattern which includes:
   - API calls
   - EventStream
   - Card Design
   - Feed
   - Json Parsing
   - Password validation system in front-end
   - Infinity Scroll View
   - Auth System with JWT token
  
2. The application is completely offline. No need to connect to the internet to fetch data. All JSON responses can be found in the ‘assets/json’ folder.

3. There is no online database system. So a data structure(List) in SharedPreferences acts as a local database. When the app is launched for the first time, It gets initialized with one user with email, first name, last name, phone number and password (which is encrypted using bCrypt).

4. The app checks for internet connection as to show how to do it. If there is an active connection, the login page will be rendered if not already logged in. There is only one user currently in the database. To pass the loginstage, a person must provide these credentials first:
   - Email     : student_one@axiluniv.com
   - Password  : password (**Passwords are not stored in plain text**)
   
5. If a user forgets password, password recovery system is introduced. The new password must pass all the validation tests to replace the old password.

6. The APIs calls are made in MainClient.dart file which is a SingleTon class. Although all calls are made in the local system, server API calls are included for **SignIn** and **GetMainFeed** methods in comment sections to demonstrate how these can be done production environment.

7. The user data structure which acts as the database of this app is designed properly to handle multiple users but the registration process is not included to make this application a simple one.
