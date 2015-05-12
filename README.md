### ruby_l10n

This is [**Ruby**](https://www.ruby-lang.org/) gem that provides localization functionalities:<br/>
- Localized strings.
- Localized dates, times, months' names and days' names with default, long, short formats.
- Localized number formats.
- Localized currency.

### Usage

1 - Bundler

In the **Gemfile** of your application, write:
```
gem 'ruby_l10n'
```
then calls:
```
bundle
```

2 - Gem
```
gem install ruby_l10n
```

Then you must add appropriate locale YAML files in to your application's **"conf/locales"** or **"config/locales"**.<br/>
Please see the files **"config/locales/en-US.yml"** and "config/locales/fr.yml" in this repo for examples.

When you want to use American English:
```ruby
locale_helper = LocaleHelper.new('en-US')
```

When you want to use French:
```ruby
locale_helper = LocaleHelper.new('fr')
```

You can add more locales as needed.<br/>
In your application, you can create multiple LocaleHelper instances, each instance is used for one language. Then you can serve multiple languages at the same time from your application based on parameters, flags or whatever you want to use to determine the languages.
