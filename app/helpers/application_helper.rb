module ApplicationHelper
include MetaTags::ViewHelper
=begin
  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end
=end

  def default_meta_tags
    {
      site: 'ImageSong（仮）',
      title: 'ImageSong（仮）',
      reverse: true,
      charset: 'utf-8',
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'イメソンを共有しあおうぜ',
      keywords: 'おたく, イメソン',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,   #優先するurlを指定する
      noindex: ! Rails.env.production?,
      icon: [                    #favicon、apple用アイコンを指定する
        { href: image_url('favicon.png') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
