require_dependency("issues_helper")

module SubtaskListAccordionHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethod)

    base.class_eval do
      # add method to IssuesHelper
      alias_method :expand_tree_at_first?, :def_expand_tree_at_first?
    end
  end

  module InstanceMethod
    def def_expand_tree_at_first?(issue, user)
      if issue.descendants.visible.count <= user.subtasks_default_expand_limit_upper
        return true
      else
        return false
      end
    end
  end
end

# include this module to IssuesHelper
IssuesHelper.send(:include, SubtaskListAccordionHelperPatch)