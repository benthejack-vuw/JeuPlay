require_relative 'earth'

$LOAD_PATH.unshift( File.join( File.join( ROOT, SOURCE ), "lib/rubytree-0.9.7/lib" ) )
$LOAD_PATH.unshift( File.join( File.join( ROOT, SOURCE ), "lib/structured_warnings-0.3.0/lib" ) )

require 'tree'
    
class TreeIndex < Tree::TreeNode
    
  def path
    File.join( content, name )
  end
  
  def populate start = path, parent = self
    Dir.glob( File.join( start,"**" ) ).select{ |d| filter d }.sort.each do |p|
      node  = self.class.new( File.basename( p ), File.dirname( p ) )
      module?( node )
      parent << node
      populate( p, node ) unless node.has_children?
    end
  end
  
  def locate node_name
    locate_all( node_name ).first
  end
  
  def locate_all node_name
    components = split_name( node_name )
    found = select{ |node| node.name =~ /#{components.last}/ }
    found.any? ? restrict_to_branch( components, found ) : []
  end
  
  def filter p
    File.directory?( p )
  end
  
  def module? node
    m = node.name.match( $ml )
    if m
      name = node.name
      name = ( name =~ /[@|\.]/ ) ? split_name( name ).last.split( /@/ ).last : name
      dir  = $module_paths[m.to_s]
      mod = self.class.new( name, dir )
      node <<  self.class.new( m.to_s, "_" ) 
      node << mod
      populate( mod.path, mod ) if m.to_s =~ /@/
    end
  end
  
  def split_name name
    name.split( /\./ )
  end
  
  def restrict_to_branch components, found
    if components.length > 1
      components.pop
      found = found.select{ |n| components.include? n.parent.name }
    end
    found
  end
  
end
  
class TreeData < TreeIndex
  
  def filter p
    !( File.basename(p).match( /^finalize$/ ) )
  end
  
end
