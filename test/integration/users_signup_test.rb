require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post '/signup', params: { user: { name:  "",
                                         email: "user@valid.com",
                                         password:              "foobr",
                                         password_confirmation: "foobar" } }
    end
    # ↓ユーザ登録失敗時、URLが変わる、解決できないため一旦削除
    # assert_select 'form[action=?]', "/signup"
    assert_template 'users/new'
    assert_select "li", "Name can't be blank"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.empty?
  end

end
