# NZBPusher

This is built for my own personal use and released without license or warranty.

You'll need to modify Settings.plist to reference your SabNZB+ installation (just the domain and port, such as http://example.org:8080) and the API key found in the Sab config.

The app currently uses [nzbindex.nl](http://nzbindex.nl) since it's the nzb search engine that I use - feel free to fork and add your own.

When it encounters a URL ending in "nzb", the app will make a request to SabNZB and try and add the nzb to your queue.