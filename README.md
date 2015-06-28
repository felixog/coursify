## How to Install Coursify

Navigate to the "coursify" directory:

       1.  Run "bundle install"
       1.  Run "rake db:migrate"

## Admin User
If you want to explore the system, we've included a default admin user in the database seeds.rb file. You may change the email address and password or just keep the defaults to explore the system.

Change ( or don't ) the seeds file to your liking and run:

    rake db:seeds

## Intercom

Open the folder in your favourite text editor and in ```Config >> Initializers >> intercom.rb```

On Line 4, replace ```your_api_id_here``` with your intercom app id.

## Pricing

Open ```app >> controllers >> application_controller.rb``` and on line 81, replace "39" with your course price.

On line 80, set ```@incremental``` to true or false, depending on whether or not you want incremental pricing on or off.

## Footer

Navigate to ```app >> views >> application >> _footer_partial.html.erb``` and update the footer with your details

## Disqus

Navigate to ```app >> views >> application >> _disqus_partial.html.erb``` and paste your disquss embed code there

## Home Page and Enroll Page

Navigate to ```app >> views >> pages >> home.html.erb``` and update the home page with your course details. Do the same for ```app >> views >> pages >> enroll.html.erb```

## Onboarding

Navigate to ```app >> views >> pages >> onboard.html.erb``` and replace lines 81, 82, 85 and 86 with two questions you want to ask your students after they enroll.

## Email

Navigate to ```app >> mailers >> notifications_mailer.rb``` and replace ```your_email_here``` on lines 3 and 4 with your actual email address (in quotes).

Navigate to ```config >> environments >> production.rb``` and on line 80, replace "Your_domain.com" with your actual domain name (without the www) inside two quotes.

Navigate to ```config >> applcation.rb``` and replace lines 16, 17, 19 and 23 with your Mandrill Details and Domain Name.

## Devise

You can also customize ```Devise >> registrations >> edit```, ```Devise >> sessions >> new```, ```Devise >> passwords >> new``` and ```Devise >> passwords >> edit``` with your course name.

## Stripe and Heroku

Finally, make sure you set your stripe api keys as environment variables in heroku, so your payment works.

And remember to migrate your heroku database

        heroku run "rake db:migrate"


You might also want to generate a new secret key for your app before you deploy to heroku, so your app is secure.
Admin User and Student User

Admin Users can be created via the console with "AdminUser.new" and Student Users (Students) are refered to as "StudentUser" in the app.

	"current_student_user" is how you get the current user object, and 		"current_admin_user" is how you get the current admin user object.
