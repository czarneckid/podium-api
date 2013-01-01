# Podium API

Podium API is the API component to a small iPhone + API Hack-A-Thon project. It uses Grape. 
If you're interested in the iOS component, you will want to check out the 
[Podium iOS](https://github.com/czarneckid/podium-ios/) project on GitHub.

## Setup

To install the dependencies, run:

```
bundle install
```

You will need a [Redis](http://redis.io) server running to run the project and the tests.

To execute the specs, run:

```
rake
```

To execute the server, run:

```
unicorn -c config/unicorn.rb
```

## Copyright

Copyright (c) 2012-2013 David Czarnecki. See LICENSE.txt for further details.
