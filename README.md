xliffer
=======

A XLIFF parser gem.

Currently implementing the [version 1.2](http://docs.oasis-open.org/xliff/xliff-core/xliff-core.html) from xliff. It is on a very alpha phase.

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
```


Roadmap
------

* Read all fields according to 1.2 specification
* Be able to modify/add contents on the xliff files
* Regenerate the XML from the file
