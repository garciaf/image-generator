# README

## Ruby version
- 3.0.2

## System dependencies
You need to have access to the file `master.key` in order to be able to decrypt every credentials

## Database creation

```
db:create
db:schema:load
```

## How to run the code locally

```
./bin/dev
```
then the application will run under http://localhost:5000/
You can change the default port by using a variable environment `PORT` with the value of your choice

## How to run the test suite
```
bundle exec rspec
```

## Services (job queues, cache servers, search engines, etc.)
### Tailwind

To compile the css to only create what is needed

```
npx tailwindcss -i app/assets/stylesheets/application.css -o app/assets/stylesheets/wind.css --watch
```

## Deployment instructions
So far only meant to run locally on my computer, since the API usage is limited and it is bounded to a personal account
