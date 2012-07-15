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

Current output options are

    insulin day DATE
    insulin month DATE
    insulin week DATE

Example:

    $ insulin day 2012-07-01
    2012-07-01
        09:41:47 BST | breakfast       | glucose    |               |  6.4 mmol/L
        09:57:09 BST | breakfast       | medication | humalog       |  4.0 x10^-5 L
        12:40:43 BST | lunch           | weight     |               | 59.0 kg
        13:54:04 BST | lunch           | glucose    |               |  5.0 mmol/L
        14:03:05 BST | lunch           | medication | humalog       |  4.0 x10^-5 L
        18:56:25 BST | dinner          | glucose    |               |  4.9 mmol/L
        19:03:37 BST | dinner          | medication | humalog       |  6.0 x10^-5 L
        21:06:01 BST | after dinner    | glucose    |               |  3.5 mmol/L
        22:32:32 BST | bedtime         | glucose    |               |  7.5 mmol/L
        22:46:12 BST | bedtime         | medication | lantus        | 14.0 x10^-5 L

        average glucose: 5.46 mmol/L

A weekly PDF summary can be generated and mailed out

    insulin pdf you@yourdmomain.com

The PDF class is currently a bit hacky, I'm still learning the excellent [prawn gem](https://github.com/prawnpdf/prawn). Requires a local SMTP server, too

You can also run the tests, if you're into that sort of thing:

    bundle exec rspec

Postfix setup
=============

OnTrack allows you to mail the exported CSV files to an email address. [This page](http://tech.jeffri.es/2010/09/automatic-ripping-and-saving-email-attachments-with-postfix/) explains how to configure Postfix to extract those files. I now have this set up so that I mail from OnTrack to particular_address@mydomain.com, the CSVs get dropped into a directory, and then 'insulin ingest' runs periodically on the newest file in that directory.

Next steps
==========

* Generate custom CSVs for spreadsheeting
* Do some analysis
* Generate some more detailed output (latest HbA1c, BP, etc)
* Give it a [meteor](http://meteor.com/) front-end (might require some help from [Chris](https://github.com/mrchrisadams)). Graphs, yo
* Connect to the Google Drive API to pull the exported CSVs (OnTrack will push there) and push spreadsheetable CSVs
* Possibly connect to [this API](http://platform.fatsecret.com/api/) to extract carb values from plain-text food descriptions (this may be a little ambitious, we'll see)

---

Project built using DDD (Diabetes-Driven Development)
