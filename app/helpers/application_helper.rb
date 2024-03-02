module ApplicationHelper
  include MetaTags::ViewHelper
  def default_meta_tags
    {
      site: 'ImageSong',
      title: 'ImageSong',
      reverse: true,
      charset: 'utf-8',
      separator: '|', # Webサイト名とページタイトルを区切るために使用されるテキスト
      description: '音楽を通して新しいコンテンツに出会うための掲示板です',
      keywords: 'おたく, イメソン', # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      noindex: !Rails.env.production?,
      icon: [
      { href: image_url('favicon.png') }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ImageSong.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ImageSong.png')
      }
    }
  end
end
