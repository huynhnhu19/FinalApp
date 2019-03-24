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

- Step 1: `rails neo4j:start`
- Step 2: `rails neo4j:migrate`
- Step 3: `rails s`