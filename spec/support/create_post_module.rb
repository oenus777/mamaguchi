module CreatepostModule
  def create_post
    visit new_post_path
    fill_in 'post_title', with: 'test'
    fill_in 'post_content', with: 'testtesttest'
    select 'test', from: 'post_category_id'
    click_button '投稿'
  end
end