module UsersHelper

  def gravatar_image_for(user)
    imagem_hash = Digest::MD5::hexdigest(user.email.downcase.strip)
    url = "https://secure.gravatar.com/avatar/#{imagem_hash}?d=mm"
    image_tag(url, alt: user.name, class: 'img-circle gravatar')
  end

  def follow_button_for(user)
    return if current_user == user
    if user_signed_in? && current_user.following?(user)
      params = params_to_unfollow user
    else
      params = params_to_follow user
    end
    button_to params[:label],
              params[:follow],
              method: params[:method], class: params[:css_class], params: params[:follow_params]
  end

  private

  def params_to_follow(user)
    {
        follow: Follow.new,
        method: :post,
        css_class: 'btn btn-sm btn-success',
        label: 'Seguir',
        follow_params: {follow:{followed_id: user.id}}
    }
  end

  def params_to_unfollow(user)
    {
        follow: current_user.follows_relation.find_by(followed: user),
        method: :delete,
        css_class: 'btn btn-sm btn-danger',
        label: 'Deixar de seguir'
    }
  end
end