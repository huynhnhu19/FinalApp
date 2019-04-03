# README

Our project is about a Social Network for Health by using Graph DB.

#### Things we may want to cover:

* Ruby version 2.6.0

* Rails version 5.2.2

* Install Neo4j(latest version, development)

#### Gems Stack

* Use Gem neo4j-core, neo4j-rake_tasks

* Authentication: gem devise-neo4j

* File attachment: gem neo4jrb-paperclip, gem carrierwave-neo4j

* Pagination: gem neo4j-will_paginate_redux, gem kaminari-neo4j

* ElasticSearch Integration: gem neo4j-searchkick

* Admin User Interface: gem rails_admin

#### Documents

* Detail about using Neo4j from Ruby: https://neo4j.com/developer/ruby/

* Document about Neo4j for Ruby here: https://neo4jrb.readthedocs.io/en/stable/ActiveNode.html


#### How to launch project
- Step 1: Run 'bundle install'
- Step 2: Run 'rake neo4j:install[community-latest]', if it have errors 'Ignoring Gem because its extensions are not built' -> run 'gem pristine --all', then run the last command again
- Step 3: check whether java is installed, if not, run 'apt-get update && apt-get upgrade', then run "apt-get install default-jdk" to install java
- Step 4: `rails neo4j:start`
- Step 4: `rails neo4j:schema:load`
- Step 5: `rails neo4j:migrate`
- Step 6: `rails s`

#### Features
- User Neoj4 database to create a Social network that have basic features below:
  1. Ability to create a User who can: create a Post, commet to a Post, to join a Group
  2. Ability to upload a Post that have: title, content( text, pic, video), comments
  ...

