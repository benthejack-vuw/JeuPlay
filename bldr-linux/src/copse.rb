class Copse
  
  def initialize constraint: :index
    @index = @module = @data = nil
    @constraint = constraint
  end
  
  attr_reader :index, :module, :data, :constraint

  def inspect
    " index = '#{@index}' \n module = '#{@module}'\n data = '#{@data}'"
  end
  
  def index= node
    @index = node ? constrain( node ) : node
  end
  
  def set_index node
    @index =  node
  end
  
  def module= node
    @module = node ? constrain( node ) : node
  end
  
  def data= node
    @data = node ? constrain( node ) : node
  end
  
  def fell forest
    rationalize
    order = @index ? to_data( forest,@index.parentage.reverse ) : []
    order << @data if @data
    order << @module if @module
    order
  end
  
  private 
  
  def to_data forest, arr
    arr.shift # ignore top level folder ( 'index' does not have a corresponding data element )
    arr.inject( [] ){ | res, elem | res << forest.data.locate( elem.name ) }
  end
  
  def rationalize
    unless @index && @index.parent && @index.name == @data.name
      @index = nil
    end
    @index = @data = nil if @module
  end
  
  def constrain node
    ( @constraint == :index ) ? latch_to_index( node ) : latch_to_parent( node )
  end
  
  def valid_node node
    node.parent && !node.parent.is_root?
  end
  
  def latch_to_parent node # a parent has children
    v_node = valid_node( node.parent ) ? node.parent : nil
    node.has_children? ? node : v_node
  end
  
  def latch_to_index node
    while valid_node( node )
      node = node.parent
    end
    node
  end
  
end