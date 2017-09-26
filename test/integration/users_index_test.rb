require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
  	@orgadmin = users(:orgadmin)
    @non_orgadmin = users(:reguser)
  end

  test "index as orgadmin including pagination and delete links" do 
    log_in_as(@orgadmin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @orgadmin
        assert_select 'a[href=?]', user_path(user), text: 'delete', method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_orgadmin)
    end
  end

  test "index as non orgadmin" do 
    log_in_as(@non_orgadmin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
