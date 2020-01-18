1. API end-points

a) sign_up
POST "/users"

b) sign_in
POST "/users/sign_in"

c) Upload files for a user
POST "/users/:user_id/files"

d) Get all files for a user
GET "/users/:user_id/files"

e) Download a file for a user
GET "/users/:user_id/files/id"

f) Delete a file for a user
DELETE "/users/:user_id/files/:id"

g) Delete account
DELETE "/users"

2. Authentication
I have used gem 'devise-jwt' for authentication.

3. Getting started

3.1 To run the rails server, you can jump to the directory:
    cd upload-file-api

3.2 Bundle install to retrieve gems:
    bundle install

3.3 Create JWT secret key by typing rake secret in terminal. Save this key in .env file as
    DEVISE_SECRET_KEY=

3.4 Start rails server in the console:
    rails s

4. Testing API using Postman

base url = "http://localhost:3000". Append this base url before each request.

a) sign_up
POST "/users"

Body:
key                     value
user[email]             test@example.com
user[password]          secret

authentication_token in response body will be null since the token is not stored in the database.
While creating new user, remove bearer token from authorization tab (if present).

b) sign_in
POST "/users/sign_in"

Body:
key                     value
user[email]             test@example.com
user[password]          secret

This request returns an authentication token in the response headers['Authorization']. This token should be used to upload, download or delete files for a user.
authentication_token in response body will be null since the token is not stored to the database.
example of authroization token in response header tab:

key              value
Authorization    Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU3OTE5OTA0MiwiZXhwIjoxNTc5Mjg1NDQyLCJqdGkiOiI0ZGI1Y2QyZC05N2Y1LTQ5YWItYTdhYi1mMjBmZWE2OWY3ODEifQ.9je9IQAe23Z2LEJp4fYmlk0JgSatCeWHG-y30P06QPA


c) Upload files for a user
POST "/users/:user_id/files"

To pass authentication token in header, go to Authorization tab and select Bearer from Type dropdown. Give the token generated during sign_in in the Token field. Click on preview request to store the token in headers.
example of token: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU3OTE5OTA0MiwiZXhwIjoxNTc5Mjg1NDQyLCJqdGkiOiI0ZGI1Y2QyZC05N2Y1LTQ5YWItYTdhYi1mMjBmZWE2OWY3ODEifQ.9je9IQAe23Z2LEJp4fYmlk0JgSatCeWHG-y30P06QPA

Body:

key                     value
user[email]             test@example.com
user[password]          secret
user[files][]           select file field from dropdown. This gives an option to attach file(s).


d) Get all files for a user
GET "/users/:user_id/files"
eg: "/users/4/files"

Remove data from body(if present)

Pass authentication token in header (same as step c above)


e) Download a file for a user
GET "users/:user_id/files/id"

Remove data from body(if present)

Pass authentication token in header (same as step c above)


f) Delete a file for a user
DELETE "users/:user_id/files/id"

Remove data from body(if present)

Pass authentication token in header (same as step c above)

g) Delete account
DELETE "/users"

Remove data from body(if present)

Pass authentication token in header (same as step c above)

This step deletes the user account as well as all his files.


5. Testing
Rspec was the testing framework used for Rails. Tests are located under app/spec/

5.1 To run the tests, go to folder:
cd upload-file-api

5.2 Run this command in the console:
rspec









