module Embulk
  module Filter

    class ScriptRuby < FilterPlugin
      Plugin.register_filter("script_ruby", self)

      def self.transaction(config, in_schema, &control)
        # configuration code:
        task = {
            'script'  => config.param('script', :string),
            'class'  => config.param('class', :string),
            'columns' => config.param('columns', :array, default: [])
        }
        
        c = 0
        out_columns = task['columns'].map do | e | 
          col = Column.new(c, e['name'], e['type'].to_sym)
          c+=1
	      col
        end
        
        yield(task, out_columns)
      end

      def init
        # initialization code:
        @script = task['script']
       
        @out_map = {}
        out_schema.each do | e |
          @out_map[e['name']] = true
        end
        
        $:.unshift "./script/"
        require @script
        @filter_class = Object.const_get(task['class']).new()
      end

      def close
      end

      def add(page)
        # filtering code:
        page.each do |record|
          begin
            h = Hash[in_schema.names.zip(record)]
            result = @filter_class.filter(h)
            out_record = []
            out_schema.sort_by{|e| e['index']}.each do | e |
              out_record << result[e['name']] if result.has_key?(e['name'])
            end
            page_builder.add(out_record) if out_record.size > 0
          rescue => e
            raise e.to_s + " backtrace: " + e.backtrace.to_s 
          end
        end
      end

      def finish
        page_builder.finish
      end
    end
    
    
  end
end
