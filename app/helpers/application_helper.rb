module ApplicationHelper
  def render_comments(comments)
    render(partial: 'comments/comment', collection: comments, as: :comment)
  end
end
