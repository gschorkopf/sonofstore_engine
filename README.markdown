# Team Ballmer's Daughter of StoreEngine
_a gSchool project by Kyle Suss, Aimee Maher, Elaine Tai, and Laura Steadman_

### View the Live Site:

#UPDATE THIS

### Installing Team Ballmer's Daughter of Store Engine on your computer:

Once you've git cloned this repo, make sure to run

```bundle install``` to load the gems used in this project

```rake db:create``` to create the database

```rake db:migrate``` to set up the database tables

```rake db:seed``` to load the products

Then, to view the site from your computer, you can then run ```unicorn``` to view it at http://localhost:8080.

##### To Run Rspec Tests on the Code
Make sure to run ``` rake db:test:prepare``` to setup your test database.
