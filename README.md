# Urchin Tracking Module

Add google analytics params to your URLs.
It's the [Google Analytics URL builder](https://support.google.com/analytics/answer/1033867?hl=en) as a gem.

## Installation

Add this line to your application's Gemfile:

    gem 'urchin_tracking_module'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install urchin_tracking_module

## Usage

    require 'urchin_tracking_module'

    UTM("http://example.com/#/welcome",
      utm_source: "newsletter_de",
      utm_medium: "email",
      utm_term:   "fashion+leather",
      utm_content: "Could be the subject line of your email",
      utm_campaign: "winter_2013" )
    => "http://example.com/?utm_source=newsletter_de&utm_medium=email&utm_term=fashion+leather&utm_content=Could+be+the+subject+line+of+your+email&utm_campaign=winter_2013#/welcome"

## Contributing

Your thought's/improvements are welcome :)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODOs

  * remove bonusbox specific `src` param or make this kind of
  additions configurable.
  * `UrchinTrackingModule.configure {|c| c[:utm_source] => 'my_app' }` could have a
  configuration object instead of a hash, to become
  `UrchinTrackingModule.configure {|c| c.utm_source = 'my_app' }`

## Code status

[![Build Status](https://travis-ci.org/bonusboxme/urchin_tracking_module.png?branch=master)](https://travis-ci.org/bonusboxme/urchin_tracking_module)

## License

This `urchin_tracking_module` project is released under the [MIT License](http://www.opensource.org/licenses/MIT).
