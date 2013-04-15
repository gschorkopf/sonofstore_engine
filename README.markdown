# Mr. Pinks' Son of StoreEngine
_a gSchool project by Erin Drummond, Daniel Mee, Laura Steadman, and Geoffrey Schorkopf_

## Welcome to Mr. Pink's Son of StoreEngine, a multi-tenancy online store

The background requirements for this project can be found at: http://tutorials.jumpstartlab.com/projects/son_of_store_engine.html

#####Extensions Completed for This Project:



### View the Live Site:

http://pink-sose.herokuapp.com/

### Installing Mr. Pink's SOSE on your computer:

Once you've git cloned this repo, make sure to run

```bundle install``` to load the gems used in this project

```rake db:create``` to create the database

```rake db:migrate``` to set up the database tables

```rake db:seed``` to load the products

Then, to view the site from your computer, you can then run ```unicorn``` to view it at http://localhost:8080.

##### To Run Rspec Tests on the Code
Make sure to run:

``` rake db:test:prepare```

to setup your test database.
