What's this?
============

Well I was recently diagnosed with Type-1 Diabetes. I've been collecting lots of data related to my condiiton using [OnTrack](https://play.google.com/store/apps/details?id=com.gexperts.ontrack), and wanted to do more interesting things with it. Hence this.

For now all it does is ingest a CSV file, parse it into some nice JSON, and stuff it into MongoDB.

Install
=======

    gem install insulin

Also requires MongoDB. Instructions for installing Mongo on Ubuntu are [here](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian-or-ubuntu-linux/).

Next steps
==========

* Get it generating custom CSVs for Spreadsheeting
* Get it doing some analysis
* Give it a [meteor](http://meteor.com/) front-end (might require some help from [Chris](https://github.com/mrchrisadams)). Graphs, yo
* Possibly connect to [this API](http://platform.fatsecret.com/api/) to extract carb values from plain-text food descriptions (this may be a little ambitious, we'll see)


