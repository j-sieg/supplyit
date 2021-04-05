# README

## Setup Instructions

*Before anything else **you must have ruby version 2.7.1 and yarn** installed.* Then:
```bash
cd supplyit
bundle install
yarn install --check-files
```

### Database Setup
*You must have a postgresql database running. **This app depends on it**.*

- Create a file named `application.yml` in the `app/config/` folder
```bash
touch config/application.yml
```

- The contents of the YAML file should be
```
development:
  DATABASE_URL: <just_your_postgres_connection_string>
```
Repeat this for any environment you wish to run the application in. The default is the development environment.
- Perform the migrations on the database
```bash
  ./bin/rails db:migrate
```
### Finally, run the application:
```bash
  ./bin/rails server
```
