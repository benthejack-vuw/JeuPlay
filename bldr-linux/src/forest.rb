require_relative 'leaf'
require_relative 'copse'

class Forest
  
  def initialize
    load_trees
    # @index.print_tree(@index.node_depth,nil, lambda { |node,prefix| puts "#{prefix} #{node.name} ,#{node.content}" })
  end
  
  attr_reader :modules, :index, :data
  
  def locate node_name, flag = :index
    node_name = node_name.strip
    c = Copse.new( constraint: flag )
    c.data = @data.locate( node_name )
    c.set_index( @index.locate( c.data.name ) ) if c.data
    c.index = @index.locate( node_name ) unless c.index
    c.module = maybe_module?( node_name )
    c.fell self
  end
  
  private
  
  def maybe_module? node_name
    node_name = ( node_name =~ /[@|\.]/ ) ? node_name.split( /\./ ).last.split( /@/ ).last : node_name
    @modules.locate( node_name )
  end
  
  def load_trees
    @modules = TreeData.new( MODULES, ROOT).tap{ |t| t.populate }
    @data    = TreeData.new( DATUM, ROOT ).tap{ |t| t.populate }
    @index   = TreeIndex.new( INDEX, ROOT).tap{ |t| t.populate }
  end
  
end