require "tree"

class FileTree
  ROOT = "".freeze
  SEPARATOR = "/".freeze

  delegate :size,
           :to_h,
           to: :root

  def initialize
    @root = Tree::TreeNode.new(ROOT)
  end

  def add_path!(path)
    return root if path == SEPARATOR

    parts = path.split(SEPARATOR)
    parent_path_parts = parts[0..-2]
    parent_path = "#{parent_path_parts.join(SEPARATOR)}"

    name = parts[-1]

    node_at_path(parent_path) << Tree::TreeNode.new(name)

    root
  end

  def node_at_path(path)
    return root if path == ROOT

    all_parts = path.split(SEPARATOR)
    non_root_parts = all_parts.reject(&:empty?)

    non_root_parts.reduce(root) do |parent, part|
      parent[part]
    end
  end
  alias_method :at_path, :node_at_path
  alias_method :at, :at_path

  private

  attr_reader :root
end
