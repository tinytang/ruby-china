require 'spec_helper'

describe Reply do
  describe "extract mention" do
    it "should extract mentioned user ids" do
      user = Factory :user
      reply = Factory :reply, :body => "@#{user.login}"
      reply.mentioned_user_ids.should == [user.id]
      reply.mentioned_user_logins.should == [user.login]
    end

    it "limit 5 mentioned user" do
      logins = ""
      6.times { logins << " @#{Factory(:user).login}" }
      reply = Factory :reply, :body => logins
      reply.mentioned_user_ids.count.should == 5
    end

    it "except self user" do
      user = Factory :user
      reply = Factory :reply, :body => "@#{user.login}", :user => user
      reply.mentioned_user_ids.count.should == 0
    end
  end
end
