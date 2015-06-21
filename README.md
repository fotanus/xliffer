[![Build Status](https://travis-ci.org/fotanus/xliffer.svg?branch=master)](https://travis-ci.org/fotanus/xliffer)
[![Test Coverage](https://codeclimate.com/github/fotanus/xliffer/badges/coverage.svg)](https://codeclimate.com/github/fotanus/xliffer/coverage)
[![Code Climate](https://codeclimate.com/github/fotanus/xliffer/badges/gpa.svg)](https://codeclimate.com/github/fotanus/xliffer)


xliffer
=======

XLIFFer helps you to parse xliff files and get their content. You can read and modify your xliff files with it.

Usage
-----

```ruby
require 'xliffer'

# Opens a xliff file - can be a file descriptor or a string.
xliff = XLIFFer::XLIFF.new(File.open('file.xml'))

# get the first file definition on this XLIFF.
file = xliff.files.first

# prints the name of this file
puts file.original

# Prints the source and target languages from this file.
puts file.source_language
puts file.target_language

# Prints all string and the translations on this file.
file.strings.each do |string|
  puts  "#{string.source} => #{string.target}"
end

# Changes the translation of texts "hi" to "oi"
file.strings.find_all { |s| s.source = "hi" }.each do |string|
  string.target = "oi"
end

# Modifies the translation of a string in the file with the given id,
# or add the translation if don't exist
file['target-string-id'].target = "new translation to this id"

# Generate the new xml file with the change
puts xliff.to_s
```


Roadmap
------

* Read all fields according to 1.2 specification
