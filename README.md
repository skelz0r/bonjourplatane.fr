# bonjourplatane.fr [![Build](https://github.com/skelz0r/bonjourplatane.fr/actions/workflows/build.yml/badge.svg)](https://github.com/skelz0r/bonjourplatane.fr/actions/workflows/build.yml)

Tous les jours, une image de platane.

## Requirements

- ruby 3.0.2

## Install

```sh
bundle install
```

Check `.env.example` for env

You have to configure Google Cloud Vision API, please follow the
[QuickStart](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-vision#quick-start)
and the
[Authentication](https://github.com/googleapis/google-cloud-ruby/blob/master/google-cloud-vision/AUTHENTICATION.md)
page to get your json keyfile.

## Run in local

```sh
./bin/local.sh
```

Then visit `http://127.0.0.1:4000/`

## Generate today post manually

Run:

```sh
bundle exec ruby bin/generate_platane_post.rb
```

## Tweet today's platane

Check `.env.local` for credentials

Run:

```sh
bundle exec ruby bin/tweet_platane.rb `date +%Y-%m-%d`
```

## Configure Github Action for today platane

Add the following secrets:

* `FLICKR_API_KEY` : Flickr API key
* `VISION_CREDENTIALS_BASE_64` : JSON key for the Google Vision API as url safe
  base64. You can use `./bin/encode_google_vision_json_key.rb` to generate this file

## Analytics

👉 https://bonjourplatane.goatcounter.com/

## Credits

Thanks to PrinceCaramel for the (stupid) idea.
