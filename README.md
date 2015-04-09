# SMS Gateway (sms2email)
[ ![Codeship Status for ATAMProductions/sms2email](https://codeship.com/projects/e3a7e130-c07e-0132-2aed-266352fa3a31/status?branch=master)](https://codeship.com/projects/73270)

This is my ugly code to turn Twilio sms into emails. It also enables me to turn a reply back to SMS to the original sender. Its an sms2email gateway!

Consider installing this to have it set up like I did:

#Ruby version: 

ruby '2.1.5'

# App dependencies: 
 
- Twilio

- Mandrill for email

- redis

- Heroku for 1 web server and 1 worker server 

# How to run the test suite: 

lol
 
One neat thing is that this is running on two heroku dynos for free (web + worker). 
The repo is pushed twice to two Heroku apps, one has a dyno worker, the other app has only a dyno web server.

Simple, free. 
Thanks Heroku!


# Loader Test
```
--pattern 1-150:60 -v:foo number[1,199] https://rygflbmadkishojc.herokuapp.com:443/smsin??ToCountry=CA&ToState=ON&SmsMessageSid=SMa1c87d031c29d882a8975d773455c107&NumMedia=0&ToCity=OTTAWA&FromZip=&SmsSid=SMa1c87d031c29d882a8975d773455c107&FromState=ON&SmsStatus=received&FromCity=OTTAWA&Body=Test#{foo}+&FromCountry=CA&To=%2B16136996738&ToZip=&MessageSid=SMa1c87d031c29d882a8975d773455c107&AccountSid=&From=%2B16138584587&ApiVersion=2010-04-01
```

 git remote -v
heroku  https://git.heroku.com/rygflbmadkishojc.git (fetch)

heroku  https://git.heroku.com/rygflbmadkishojc.git (push)

origin  git@bitbucket.org:massaad/new-sms2email.git (fetch)

origin  git@bitbucket.org:massaad/new-sms2email.git (push)

worker  https://git.heroku.com/rygflbmadkishojc-worker.git (fetch)

worker  https://git.heroku.com/rygflbmadkishojc-worker.git (push)
