# Little Git Shop

We have built a JSON API that imports data and uses it to create endpoints while performing business intelligence calculations.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

From GitHub clone down repository using the following commands in terminal:
* git clone git@github.com:jplao/rales_engine.git
* git clone git@github.com:turingschool/rales_engine_spec_harness.git
* cd rales_engine

### Prerequisites

You will need Rails installed and verify that it is version 5.1 and NOT 5.2

To check your version using terminal run: rails -v in the command line.
If you have not installed rails, in terminal run: gem install rails -v 5.1 in the command line.


### Installing

Open terminal and run these commands:
* bundle
* bundle update
* rake db:{drop,create,migrate,seed}
* rake import:all
* rails s

Open up a web browser (preferably Chrome)

Navigate to specific endpoint (ie. localhost:3000/api/v1/merchants)

To shut down the server use: control + c

## Running the rspec tests

* Note: Before running RSpec, ensure you're in the project root directory.

From terminal run: rspec

After RSpec has completed, you should see all tests passing as GREEN.  Any tests that have failed or thrown an error will display RED.  Any tests that have been skipped will be displayed as YELLOW.

## Running the spec harness tests

In one terminal tab, run your server using the command: rails s
In another terminal tab, change directories using: cd rales_engine_spec_harness
  Then run the spec harness tests using the command: rake

After the spec harness has completed, you should see corresponding numbers for the number of tests run, the number of assertions made, the number of test failures, the number of test errors, and the umber of tests skipped.


## Built With

* Rails
* RSpec
* ShouldaMatchers
* Capybara
* Launchy
* Pry
* SimpleCov
* FactoryBot
* BCrypt
* PostreSQL
* ActiveRecord
* Fast_json

## Versioning

GitHub, lots of GitHub

## Authors

* Jennifer Lao - Github: jplao
