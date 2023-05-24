# README Hop Skip Drive

A rest web application that provides an open API that calculates the commute distance and ride distance and sort them on the basis of their score. This uses Open Route API service to calculate distance from driver to rider and to the required destination. The data recieved from API service is then cached into the memory in order to increase the performane and decrease the number of API request performed to fetch data for each ride. This also provides swagger documentation for the corresponding API.
_____

- Ruby version

  _*v2.7.5*_

- Dependencies

  - Postgresql
  - rails v7.0.4

Run `bundle install` on terminal

- ## Configuration

  - Add Open Source URL in config/application.yml
  - Add Open Source API key in config/application.yml
  - Configure pgsql and add db password in config/application.yml

- Database creation

  - After pgsql config, run following on terminal
    - `rails db:create`
    - `rails db:migrate`
    - `rails db:seed`

- How to run the test suite
  - run on terminal `rspec`

### Documentation URL

_/api_docs_
