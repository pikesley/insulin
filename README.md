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

To suck in some data

    insulin ingest </path/to/on_track_export_file.csv>

This will take that file, parse it, and push the JSON into a number of collections in a MongoDB database called 'insulin'. You can view them with something like

    $ mongo insulin
    MongoDB shell version: 2.0.6
    connecting to: insulin
    > db.events.find({serial : 266})
    { "_id" : ObjectId("4ff07b371508cc259c8a8f0c"), "serial" : 266, "timestamp" : ISODate("2012-06-28T09:21:05Z"), "tzoffset" : "+0100", "timezone" : "BST", "unixtime" : 1340875265, "day" : "thursday", "date" : "2012-06-28", "time" : "10:21:05 BST", "type" : "medication", "subtype" : "humalog", "tag" : "breakfast", "value" : 4, "notes" : { "food" : [ "2 bacon", "2 toast" ], "note" : [ "test note" ] } }
    > 

Currently the only supported output operation is

    insulin day DATE

to show stats for date DATE (in YYYY-MM-DD format) - defaults to 'today' if no date supplied. Note that insulin considers events that occur up to 04:00 as part of the previous actual day (because sometimes we stay up late, right?). Output will look something like

    2012-07-06
              06:50:54 BST glucose                6.4 mmol/L
              07:05:38 BST weight                59.0 kg
              09:43:33 BST glucose                6.7 mmol/L
              09:50:23 BST medication humalog     4.0 x10^-5 L
              13:17:43 BST glucose                4.7 mmol/L
              13:31:44 BST medication humalog     4.0 x10^-5 L
              15:57:12 BST glucose                6.2 mmol/L
              20:01:41 BST glucose                6.2 mmol/L
              20:05:21 BST medication humalog     6.0 x10^-5 L
              21:42:38 BST glucose                9.0 mmol/L
              00:34:22 BST glucose                9.5 mmol/L
              00:49:27 BST medication lantus     12.0 x10^-5 L
              Average glucose: 6.96 mmol/L

You can also run the tests, if you're into that sort of thing:

    bundle exec rspec

Postfix setup
=============

OnTrack allows you to mail the exported CSV files to an email address. [This page](http://tech.jeffri.es/2010/09/automatic-ripping-and-saving-email-attachments-with-postfix/) explains how to configure Postfix to extract those files. I now have this set up so that I mail from OnTrack to particular_address@mydomain.com, the CSVs get dropped into a directory, and then 'insulin ingest' runs periodically on the newest file in that directory.

Next steps
==========

* Get it generating custom CSVs for Spreadsheeting
* Get it doing some analysis
* Give it a [meteor](http://meteor.com/) front-end (might require some help from [Chris](https://github.com/mrchrisadams)). Graphs, yo
* Possibly connect to [this API](http://platform.fatsecret.com/api/) to extract carb values from plain-text food descriptions (this may be a little ambitious, we'll see)

---

Project built using DDD (Diabetes-Driven Development)
