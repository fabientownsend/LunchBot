# LunchBot
A ruby slack bot that assists you when ordering your lunch.

[![Build Status](https://travis-ci.org/willcurry/LunchBot.svg?branch=master)](https://travis-ci.org/willcurry/LunchBot)
[![Coverage Status](https://coveralls.io/repos/github/willcurry/LunchBot/badge.svg?branch=master)](https://coveralls.io/github/willcurry/LunchBot?branch=master)

# Configuring
You have to set these enviorment variables to the ones you have on Slack.

``` bash
export SLACK_CLIENT_ID="XXXX.XXXX"
export SLACK_API_SECRET="XXXX"
export SLACK_VERIFICATION_TOKEN="XXXX"
export SLACK_REDIRECT_URI="XXXX"
```

If you want BambooHR to automatically mark people out:

``` bash
export BAMBOO_HR_API_KEY="XXXX"
```

# Slack Commands
Type help or look in the command_info.rb file to view all commands.

# TODO
- Refactor reminder class.
- Cache BambooAPI requests in memory.
- Create an error message moudle.
- Fix naming inconsistencies.
- Emoji responses sepcific to lunch order.
- General clean up of classes having more then one responsibility.

# Development
You can add a new command with
``` bash
ruby ./bin/command_creator.rb new command ClassName
```

This will create a command with the method need in: `lib/commands` and its test in `spec/commands`.

To make your new command effective you simply need to add your commands class to the `lib/request_parser`.
