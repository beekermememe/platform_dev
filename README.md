Ibotta Dev Project
=========

##Requirements:
- Ruby Version 2.2.6
- Sqlite3

##Setup:
In the terminal
- Install RVM - see https://rvm.io
- Install ruby version 2.2.6 - ```rvm install 2.2.6```
- Install bundlers - ```rvm use 2.2.6; gem install bundler```
- cd to the project directory
- Install the gems - ```bundle install```
- Set up database - ```bundle exec rake db:create:all; rake db:migrate```
- Load all the data into the system - ```bundle exec rake startup:reload_all_data```

At this point you are ready to validate the app using the provided test files. To do this run the comment ```ruby anagram_test.rb``` (note you need to have the server up and running when you run this test suite). All the tests should pass

##Testing:
- We are using rspec for testing. See[rspec](http://rspec.info)
- To run all the tests - ```bundle exec rake spec```. See the rspec docs on how to run individual specs.

## API Documentation
To get the api documentation you will need to start the server and navigate to the apidocs url -[http://localhost:3000/apipie](http://localhost:3000/apipie). We are using[apipie](https://github.com/Apipie/apipie-rails)to support this documentation.

## Project Notes
1. There were a 3 endpoint that were optional that are not present, but I will discuss them here
- Endpoint that takes a set of words and returns whether or not they are all anagrams of each other. This is not too clear on how the endpoint would return the results. In any case I would suggest we use the method Anagram.get_key on each word and find matches of the keys.
- Endpoint to return all anagram groups of size >= *x*. I would suggest looking into using the same style of login in Anagram.find_all_words_with_the_maximum_number_of_anagrams, but rather than looking for all the anagram_keys in the max group, use the limit of the group size.
- Endpoint to delete a word *and all of its anagrams*. I would suggest we use the method Anagram.get_key to find the matching anagrams to the word passed.

2. Discussion

- The first point to address here would be to look into either session authentication or at least an apikey on the Delete and Post methods. It is definitely a little scary to have them hanging out there.
- DB selection. For simplicity, I used sqlite3. This makes the app easily portable. From a scalability standpoint however, this is not the answer. On selection of a DB/Datastore there are a number of items to determine, some of which are:
    - What are the endpoints that will get the most traffic - what queries do they hit?
    - When making queries, how "real-time" do we need the data to be? (especially regarding the stats)
    - If we are implementing authentication, will this affect result sets
    - Are there other systems that need access to our data
    - What kind of response times are we looking for
    - Backup/Restore requirements
    - How big do we see the data getting?
    - At the moment, a key value store may just fine for the anagram search but what else is coming down the pipeline?
- Caching. We have no caching at the moment. We need to look at what are the main queries/endpoints that get traffic. We would need to see if it is even worth caching if the queries are always unique. It maybe worth looking into a different method of data storage - redis key/value store?
- Refreshing the WordStat table. We need to decide if we need this run on a periodic basis or on an after-save when a new word is added/deleted?
- Another thing that would be worth investing time in would be adding a standard error handling response from the API's. Should be return 404 if an anagram does not exist or if the word we wish to delete does not exist. When we add words, should be return feedback if a word already exists?
- When approaching this project, I tried to not try to think too ahead. Especially when it came to the anagram search section. After looking at the project at first, I left this part to the end of the initial implementation. And rather than trying to integrate a solution into the databaase, I went with a code first approach. It was only then, once I had the mechanism as to where I saw the actual algorithm understood, I then moved to the DB to see if I could leverage it for performance. Depending on the DB available, it may have mechanisms (e.g stored proceedures) that we could leverage in the future.
- I did not spend a huge amount of time on the data ingestion side. Based on the DB architecture, I left this for later since fast data ingestion is very much datastore specific.
- Where I felt applicable, I added default parameters. However, it would be good to place documented limits on (1) The amount of words you want to add (2) The number of anagram matches you want to get

Initial Specifications
======================
# The Project

---

The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). `dictionary.txt` is a text file containing every word in the English dictionary. Ingesting the file doesn’t need to be fast, and you can store as much data in memory as you like.

The API you design should respond on the following endpoints as specified.

- `POST /words.json`: Takes a JSON array of English-language words and adds them to the corpus (data store).
- `GET /anagrams/:word.json`:
  - Returns a JSON array of English-language words that are anagrams of the word passed in the URL.
  - This endpoint should support an optional query param that indicates the maximum number of results to return.
- `DELETE /words/:word.json`: Deletes a single word from the data store.
- `DELETE /words.json`: Deletes all contents of the data store.


**Optional**
- Endpoint that returns a count of words in the corpus and min/max/median/average word length
- Respect a query param for whether or not to include proper nouns in the list of anagrams
- Endpoint that identifies words with the most anagrams
- Endpoint that takes a set of words and returns whether or not they are all anagrams of each other
- Endpoint to return all anagram groups of size >= *x*
- Endpoint to delete a word *and all of its anagrams*

Clients will interact with the API over HTTP, and all data sent and received is expected to be in JSON format

Example (assuming the API is being served on localhost port 3000):

```{bash}
# Adding words to the corpus
$ curl -i -X POST -d '{ "words": ["read", "dear", "dare"] }' http://localhost:3000/words.json
HTTP/1.1 201 Created
...

# Fetching anagrams
$ curl -i http://localhost:3000/anagrams/read.json
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dear",
    "dare"
  ]
}

# Specifying maximum number of anagrams
$ curl -i http://localhost:3000/anagrams/read.json?limit=1
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dare"
  ]
}

# Delete single word
$ curl -i -X DELETE http://localhost:3000/words/read.json
HTTP/1.1 200 OK
...

# Delete all words
$ curl -i -X DELETE http://localhost:3000/words.json
HTTP/1.1 204 No Content
...
```

Note that a word is not considered to be its own anagram.


## Tests

We have provided a suite of tests to help as you develop the API. To run the tests you must have Ruby installed ([docs](https://www.ruby-lang.org/en/documentation/installation/)):

```{bash}
ruby anagram_test.rb
```

Only the first test will be executed, all the others have been made pending using the `pend` method. Delete or comment out the next `pend` as you get each test passing.

If you are running your server somewhere other than localhost port 3000, you can configure the test runner with configuration options described by

```{bash}
ruby anagram_test.rb -h
```

You are welcome to add additional test cases if that helps with your development process. The [benchmark-bigo](https://github.com/davy/benchmark-bigo) gem is helpful if you wish to do performance testing on your implementation.

## API Client

We have provided an API client in `anagram_client.rb`. This is used in the test suite, and can also be used in development.

To run the client in the Ruby console, use `irb`:

```{ruby}
$ irb
> require_relative 'anagram_client'
> client = AnagramClient.new
> client.post('/words.json', nil, { 'words' => ['read', 'dear', 'dare']})
> client.get('/anagrams/read.json')
```

## Documentation

Optionally, you can provide documentation that is useful to consumers and/or maintainers of the API.

Suggestions for documentation topics include:

- Features you think would be useful to add to the API
- Implementation details (which data store you used, etc.)
- Limits on the length of words that can be stored or limits on the number of results that will be returned
- Any edge cases you find while working on the project
- Design overview and trade-offs you considered


# Deliverable
---

Please provide the code for the assignment either in a private repository (GitHub or Bitbucket) or as a zip file. If you have a deliverable that is deployed on the web please provide a link, otherwise give us instructions for running it locally.
