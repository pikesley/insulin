What's this?
============

Well I was recently diagnosed with Type-1 Diabetes. I've been collecting lots of data related to my condiiton using [OnTrack](https://play.google.com/store/apps/details?id=com.gexperts.ontrack), and wanted to do more interesting things with it. Hence this.

For now all it does is ingest a CSV file, parse it into some nice JSON, and stuff it into MongoDB.

Install
=======

    gem install insulin

Also requires MongoDB. Instructions for installing Mongo on Ubuntu are [here](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian-or-ubuntu-linux/).

Usage
=====

    insulin ingest </path/to/on_track_export_file.csv>

This will take that file, parse it, and push the JSON into a number of collections in a MongoDB database called 'insulin'. You can view them with something like

    $ mongo insulin
    MongoDB shell version: 2.0.6
    connecting to: insulin
    > db.events.find({serial : 266})
    { "_id" : ObjectId("4ff07b371508cc259c8a8f0c"), "serial" : 266, "timestamp" : ISODate("2012-06-28T09:21:05Z"), "tzoffset" : "+0100", "timezone" : "BST", "unixtime" : 1340875265, "day" : "thursday", "date" : "2012-06-28", "time" : "10:21:05 BST", "type" : "medication", "subtype" : "humalog", "tag" : "breakfast", "value" : 4, "notes" : { "food" : [ "2 bacon", "2 toast" ], "note" : [ "test note" ] } }
    > 

You can also run the tests, if you're into that sort of thing:

    bundle exec rspec

There's also some Postfix voodoo I've been using to extract the CSVs from incoming mail, which I'll document here soon.

Next steps
==========

* Get it generating custom CSVs for Spreadsheeting
* Get it doing some analysis
* Give it a [meteor](http://meteor.com/) front-end (might require some help from [Chris](https://github.com/mrchrisadams)). Graphs, yo
* Possibly connect to [this API](http://platform.fatsecret.com/api/) to extract carb values from plain-text food descriptions (this may be a little ambitious, we'll see)

Project built using DDD (Diabetes-Driven Development)
