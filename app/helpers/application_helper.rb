module ApplicationHelper
  def default_meta_tags
    {
      site: 'Bibouroku',
      title: 'ゼロイチ',
      reverse: true,
      charset: 'utf-8',
      description: 'エンジニアがゼロイチで何か作りたいものがあるとき要件や実装したい機能を定義していき誰かが参考URLを貼ってくれたりするサイト。どのサイトで解決したかを備忘録としてもスタックしていきましょう。ToDoにもなります。',
      keywords: 'URL共有,タスク管理,ゼロイチ,一緒に勉強,プログラミング,プロジェクト TODO',
      canonical: request.original_url,
      separator: '|',
      #icon: [
      #  { href: image_url('favicon.ico') },
      #  { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      #],
      og: {
        site_name: 'Bibouroku',
        title: 'ゼロイチ',
        description: 'エンジニアゼロイチで何か作りたいものがあるとき要件や実装したい機能を定義していき誰かが参考URLを貼ってくれたりするサイト。どのサイトで解決したかを備忘録としてもスタックしていきましょう。ToDoにもなります。',
        type: 'website',
        url: request.original_url,
        image: image_url(''),
        locale: 'ja_JP',
      },
    }
  end
end
