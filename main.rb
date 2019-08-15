Bundler.require
require 'highline/import'

# selenium で扱う windows サイズ & 画像トリミング時のスケール揃えに使用
# burnup chart ページにアクセスしたときにチャートグラフが収まるサイズにしている
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 1200

IMAGE_PATH = 'img'
SCREENSHOT_FILE_PATH = IMAGE_PATH + '/screenshot.png'
TRIMMED_FILE_PATH = IMAGE_PATH + '/trimmed.png'

require_paths = ['helpers', 'helpers/selenium_targets', 'actions', 'handlers']

require_paths.each do |require_path|
  Dir.glob("#{require_path}/*") do |path|
    require_relative path
  end
end
