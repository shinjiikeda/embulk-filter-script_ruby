module Embulk
  module Filter

    class ScriptRuby < FilterPlugin
      Plugin.register_filter("script_ruby", self)

      def self.transaction(config, in_schema, &control)
        # configuration code:
        task = {
            'path'  => config.param('path', :string),
            'columns' => config.param('columns', :array, default: [])
        }
        
        _columns = []
        @out_columns_map = {}
        task['columns'].each do | c |
          Column.new(nil, c['name'], c['type'].to_sym)
          @out_columns_map[c['name']] = true
        end

        out_columns = _columns

        yield(task, out_columns)
      end

      def init
        # initialization code:
        @path = task['path']
        load_script_file(@path)
      end

      def close
      end

      def add(page)
        # filtering code:
        page.each do |record|
          result = {}
          filter(hash_record(record)).each do |key, value|
            result[key] = value if @out_columns_map.has_key?(key)
          end
          page_builder.add(record)
        end
      end

      def finish
        page_builder.finish
      end
    end
    
    private
    
    def load_script_file(path)
        raise ConfigError, "Ruby script file does not exist: #{path}" unless File.exist?(path)
	    eval "self.instance_eval do;" + IO.read(path) + ";end"
    end

    def hash_record(record)
      Hash[in_schema.names.zip(record)]
    end

  end
end
