1. API end-points

a) sign-up
POST "/users"

b) sign_in
POST "/users/sign_in"

c) Upload files for a user
POST "/users/:user_id/files"

d) Get all files for a user
GET "users/:user_id/files"

e) Download a file for a user
GET "users/:user_id/files/id"

f) Delete a file for a user
DELETE "users/:user_id/files/id"

2. Authentication
I have used gem 'devise-jwt' for authentication. Create JWT secret key by typing rake secret in terminal. Save this key in .env file as
DEVISE_SECRET_KEY=

3. Testing API using Postman
Start rails server from terminal
rails s

a) sign-up
POST "/users"

Body:
key                     value
user[email]             test@example.com
user[password]          secret


b) sign_in
POST "/users/sign_in"

Body:
key                     value
user[email]             test@example.com
user[password]          secret

This request returns an authentication token in the response headers['Authorization']. This token should be used to upload, download or delete files for a user.
eg of authroization token in response header tab:

key              value
Authorization    Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU3OTE5OTA0MiwiZXhwIjoxNTc5Mjg1NDQyLCJqdGkiOiI0ZGI1Y2QyZC05N2Y1LTQ5YWItYTdhYi1mMjBmZWE2OWY3ODEifQ.9je9IQAe23Z2LEJp4fYmlk0JgSatCeWHG-y30P06QPA


c) Upload files for a user
POST "/users/:user_id/files"

To pass authentication token in header, go to Authorization tab and select Bearer from Type dropdown. Give the token generated during sign_in in the Token field.
for eg: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU3OTE5OTA0MiwiZXhwIjoxNTc5Mjg1NDQyLCJqdGkiOiI0ZGI1Y2QyZC05N2Y1LTQ5YWItYTdhYi1mMjBmZWE2OWY3ODEifQ.9je9IQAe23Z2LEJp4fYmlk0JgSatCeWHG-y30P06QPA

Body:

key                     value
user[email]             test@example.com
user[password]          secret
user[files][]           select file field from dropdown. This gives an option to attach file(s)


d) Get all files for a user
GET "users/:user_id/files"
eg: "users/4/files"

Pass authentication token in header (same as step c above)


e) Download a file for a user
GET "users/:user_id/files/id"

Pass authentication token in header (same as step c above)


f) Delete a file for a user
DELETE "users/:user_id/files/id"

Pass authentication token in header (same as step c above)









