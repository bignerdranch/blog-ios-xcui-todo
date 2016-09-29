#!/usr/bin/env bash

if [ "$BUDDYBUILD_SCHEME" == "XCUITodo Tests" ]
  then
    echo "Creating buddybuild_settings.json"
    echo "{ \"skip_xcodebuild\": true }" > buddybuild_settings.json
fi
