# Script Ruby filter plugin for Embulk

TODO: Write short description here and embulk-filter-script_ruby.gemspec file.

## Overview

* **Plugin type**: filter

## Configuration

- **script**: script file (string, required)
- **class**: class name (string, required)
- **columns**: output columns (array, default: `null`)

## Example

```yaml
filters:
  - type: script_ruby
    script: filter_hoge
    class: FilterHoge
    columns:
      - {name: id, type: string}
      ...
```

filter_hoge.rb
```ruby
class FilterHoge
  def initialize()
    ...
  end
  
  def filter(record)
    ...
    record
  end
end
```

```
$ embulk run -I lib config.yml
```

## Build

```
$ rake
```
