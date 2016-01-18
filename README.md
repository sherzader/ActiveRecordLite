# ActiveRecord Lite

## Object Relational Mapper

My implementation of an ORM using a SQLite3 database. Built using TDD via RSpec.

## How to Use
* Download zip, run `bundle install`
* Personalize for your schemas by building your database:
### For your Database
* Add the appropriate gem for your db, may it be `pg` or `sqlite3`
* Run `bundle install`
* In a `.sql` file in the root of the ActiveRecord directory, build your tables

## Features
* `::all`
* `::find`
* `#insert`
* `#update`
* `#save`
* `::where`
* `belongs_to`, `has_many`, `has_one_through`

ToDo
- [ ] Build into a Rails framework, then
- [ ] Integrate into a full-stack application
- [ ] Validation methods/validator class
- [ ] `includes` method to pre-fetch and remove N+1 queries
