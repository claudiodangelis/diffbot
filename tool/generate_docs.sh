#!/bin/bash
dartdoc --out=docs --package-root=packages --exclude-lib=js,js.wrapping,meta,metadata,utils lib/diffbot_browser.dart lib/diffbot_console.dart
