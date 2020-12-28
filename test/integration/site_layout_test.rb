require 'test_helper'
  class SiteLayoutTest < ActionDispatch::IntegrationTest
  #統合テスト
  #rails test:integrationで起動
    test "layout links" do
      get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      #Railsは自動的にはてなマーク "?" をabout_pathに置換しています
      #<a href="/about">...</a>のようなhtmlがあるか確認する
      assert_select "a[href=?]", contact_path
      get contact_path
      assert_select "title", full_title("Contact")  
    end
  end

#ルートURL (Homeページ) にGETリクエストを送る.
#正しいページテンプレートが描画されているかどうか確かめる.
#Home、Help、About、Contactの各ページへのリンクが正しく動くか確かめる.
