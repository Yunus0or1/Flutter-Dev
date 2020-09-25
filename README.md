# Flutter_Dev

1. A basic Flutter application implementing **Reactive and SingleTon** Design pattern which includes:
   - API calls
   - EventStream
   - Card Design
   - Json Parsing
  
2. The application is completely offline. No need to connect to the internet to fetch data. All JSON responses can be found in the ‘assets/json’ folder.

3. There is no online database system. So a data structure(List) in SharedPreferences acts as a local database. When the app is launched for the first time, It gets initialized with one user with email, first name, last name, phone number and password (which is encrypted using bCrypt).

4. The app checks for internet connection as to show how to do it. If there is an active connection, the login page will be rendered if not already logged in. There is only one user currently in the database. To pass the loginstage, a student/authority must provide these credentials first:
   - Email: student_one@axiluniv.com
   - Pass: password (**Passwords are not stored in plan text**)
 
