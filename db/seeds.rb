# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

User.create(:id => 1,:name => "testmama",:email => "test@test.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 6,:name => "othermama",:email => "other@other.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 7,:name => "aaamama",:email => "aaa@aaa.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 8,:name => "bbbmama",:email => "bbb@bbb.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 9,:name => "cccmama",:email => "ccc@ccc.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 10,:name => "dddmama",:email => "ddd@ddd.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)
User.create(:id => 11,:name => "eeemama",:email => "eee@eee.com",:password => "testtest3",
            :password_confirmation => "testtest3",:confirmed_at => Time.now)

Category.create(:id => 1,:name => "育児")
Category.create(:id => 2,:name => "旦那")
Category.create(:id => 3,:name => "両親")
Category.create(:id => 4,:name => "義父母")
Category.create(:id => 5,:name => "ママ友")
Category.create(:id => 6,:name => "友達")
Category.create(:id => 7,:name => "ご近所関係")
Category.create(:id => 8,:name => "学校関係")
Category.create(:id => 9,:name => "教育")
Category.create(:id => 10,:name => "お金")
Category.create(:id => 11,:name => "感情面")
Category.create(:id => 12,:name => "ワンオペ")
Category.create(:id => 13,:name => "子供の体調")
Category.create(:id => 14,:name => "仕事")
Category.create(:id => 15,:name => "その他")