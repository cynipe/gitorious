# encoding: utf-8
#--
#   Copyright (C) 2007-2009 Johan Sørensen <johan@johansorensen.com>
#   Copyright (C) 2008 David Chelimsky <dchelimsky@gmail.com>
#   Copyright (C) 2008 David A. Cuadrado <krawek@gmail.com>
#   Copyright (C) 2008 Tim Dysinger <tim@dysinger.net>
#   Copyright (C) 2008 David Aguilar <davvid@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require File.dirname(__FILE__) + '/../test_helper'
require "ostruct"

class RepositoryTest < ActiveSupport::TestCase
  
  def new_repos(opts={})
    Repository.new({
      :name => "foo",
      :project => projects(:johans),
      :user => users(:johan),
      :owner => projects(:johans)
    }.merge(opts))
  end

  def setup
    @repository = new_repos
    FileUtils.mkdir_p(@repository.full_repository_path, :mode => 0755)
  end

  should " have a name to be valid" do
    @repository.name = nil
    assert !@repository.valid?, 'valid? should be false'
  end
  
  should " only accept names with alphanum characters in it" do
    @repository.name = "foo bar"
    assert !@repository.valid?, 'valid? should be false'
    
    @repository.name = "foo!bar"
    assert !@repository.valid?, 'valid? should be false'
    
    @repository.name = "foobar"
    assert @repository.valid?
    
    @repository.name = "foo42"
    assert @repository.valid?
  end
  
  should "has a unique name within a project" do
    @repository.save
    repos = new_repos(:name => "FOO")
    assert !repos.valid?, 'valid? should be false'
    assert_not_nil repos.errors.on(:name)
    
    assert new_repos(:project => projects(:moes)).valid?
  end
  
  should "cannot have a reserved name" do
    repo = new_repos(:name => Gitorious::Reservations::REPOSITORY_NAMES.first)
    repo.valid?
    assert_not_nil repo.errors.on(:name)
  end
  
  should "sets itself as mainline if the owner is Project" do
    @repository.project = nil
    @repository.owner = projects(:johans)
    @repository.save
    assert @repository.mainline?, '@repository.mainline? should be true'
    assert_equal projects(:johans), @repository.project
  end
  
  should "doesn't set itself as mainline if the owner is a Group" do
    @repository.owner = groups(:team_thunderbird)
    @repository.save
    assert !@repository.mainline?, '@repository.mainline? should be false'
  end
  
  should "doesn't set itself as mainline if the owner is a User" do
    @repository.owner = users(:johan)
    @repository.save
    assert !@repository.mainline?, '@repository.mainline? should be false'
  end
  
  should "has a gitdir name" do
    assert_equal "#{@repository.project.slug}/foo.git", @repository.gitdir
  end
  
  should "has a push url" do
    assert_equal "#{GitoriousConfig['gitorious_user']}@#{GitoriousConfig['gitorious_host']}:#{@repository.project.slug}/foo.git", @repository.push_url
  end
  
  should "has a clone url" do
    assert_equal "git://#{GitoriousConfig['gitorious_host']}/#{@repository.project.slug}/foo.git", @repository.clone_url
  end
  
  should "has a http url" do
    assert_equal "http://git.#{GitoriousConfig['gitorious_host']}/#{@repository.project.slug}/foo.git", @repository.http_clone_url
  end
  
  should "has a clone url with the project name, if it's a mainline" do
    @repository.owner = groups(:team_thunderbird)
    @repository.mainline = true
    assert_equal "git://#{GitoriousConfig['gitorious_host']}/#{@repository.project.slug}/foo.git", @repository.clone_url
  end
  
  should "has a push url with the project name, if it's a mainline" do
    @repository.owner = groups(:team_thunderbird)
    @repository.mainline = true
    assert_equal "#{GitoriousConfig['gitorious_user']}@#{GitoriousConfig['gitorious_host']}:#{@repository.project.slug}/foo.git", @repository.push_url
  end
  
  should "has a http clone url with the project name, if it's a mainline" do
    @repository.owner = groups(:team_thunderbird)
    @repository.mainline = true
    assert_equal "http://git.#{GitoriousConfig['gitorious_host']}/#{@repository.project.slug}/foo.git", @repository.http_clone_url
  end
  
  should "has a full repository_path" do
    expected_dir = File.expand_path(File.join(GitoriousConfig["repository_base_path"], 
      "#{@repository.full_hashed_path}.git"))
    assert_equal expected_dir, @repository.full_repository_path
  end
  
  should "inits the git repository" do
    path = @repository.full_repository_path
    Repository.git_backend.expects(:create).with(path).returns(true)
    Repository.create_git_repository(@repository.real_gitdir)
    
    assert File.exist?(path), 'File.exist?(path) should be true'
    
    Dir.chdir(path) do
      hooks = File.join(path, "hooks")
      assert File.exist?(hooks), 'File.exist?(hooks) should be true'
      assert File.symlink?(hooks), 'File.symlink?(hooks) should be true'
      assert File.symlink?(File.expand_path(File.readlink(hooks))), 'File.symlink?(File.expand_path(File.readlink(hooks))) should be true'
    end
  end
  
  should "clones a git repository" do
    source = repositories(:johans)
    target = @repository
    target_path = @repository.full_repository_path
    
    git_backend = mock("Git backend")
    Repository.expects(:git_backend).returns(git_backend)
    git_backend.expects(:clone).with(target.full_repository_path, 
      source.full_repository_path).returns(true)
    Repository.expects(:create_hooks).returns(true)
    
    assert Repository.clone_git_repository(target.real_gitdir, source.real_gitdir)
  end
  
  should " create the hooks" do
    hooks = "/path/to/hooks"
    path = "/path/to/repository"
    base_path = "#{RAILS_ROOT}/data/hooks"
    
    File.expects(:join).in_sequence.with(GitoriousConfig["repository_base_path"], ".hooks").returns(hooks)
    
    Dir.expects(:chdir).in_sequence.with(path).yields(nil)
    
    File.expects(:symlink?).in_sequence.with(hooks).returns(false)
    File.expects(:exist?).in_sequence.with(hooks).returns(false)
    FileUtils.expects(:ln_s).in_sequence.with(base_path, hooks)
    
    local_hooks = "/path/to/local/hooks"
    File.expects(:join).in_sequence.with(path, "hooks").returns(local_hooks)
    
    File.expects(:exist?).in_sequence.with(local_hooks).returns(true)
    
    File.expects(:join).with(path, "description").in_sequence
    
    File.expects(:open).in_sequence.returns(true)
    
    assert Repository.create_hooks(path)
  end
  
  should "deletes a repository" do
    Repository.git_backend.expects(:delete!).with(@repository.full_repository_path).returns(true)
    Repository.delete_git_repository(@repository.real_gitdir)
  end
  
  should "knows if has commits" do
    @repository.stubs(:new_record?).returns(false)
    @repository.stubs(:ready?).returns(true)
    git_mock = mock("Grit::Git")
    @repository.stubs(:git).returns(git_mock)
    head = mock("head")
    head.stubs(:name).returns("master")
    @repository.git.expects(:heads).returns([head])
    assert @repository.has_commits?, '@repository.has_commits? should be true'
  end
  
  should "knows if has commits, unless its a new record" do
    @repository.stubs(:new_record?).returns(false)
    assert !@repository.has_commits?, '@repository.has_commits? should be false'
  end
  
  should "knows if has commits, unless its not ready" do
    @repository.stubs(:ready?).returns(false)
    assert !@repository.has_commits?, '@repository.has_commits? should be false'
  end
  
  should " build a new repository by cloning another one" do
    repos = Repository.new_by_cloning(@repository)
    assert_equal @repository, repos.parent
    assert_equal @repository.project, repos.project
    assert repos.new_record?, 'new_record? should be true'
  end
  
  should "suggests a decent name for a cloned repository bsed on username" do
    repos = Repository.new_by_cloning(@repository, username="johan")
    assert_equal "johan-clone", repos.name
    repos = Repository.new_by_cloning(@repository, username=nil)
    assert_equal nil, repos.name
  end
  
  should "has it's name as its to_param value" do
    @repository.save
    assert_equal @repository.name, @repository.to_param
  end
  
  should "finds a repository by name or raises" do
    assert_equal repositories(:johans), Repository.find_by_name!(repositories(:johans).name)
    assert_raises(ActiveRecord::RecordNotFound) do
      Repository.find_by_name!("asdasdasd")
    end
  end
  
  context "find_by_path" do
    should "finds a repository by its path" do
      repo = projects(:johans).repositories.mainlines.first
      path = File.join(GitoriousConfig['repository_base_path'], 
                        projects(:johans).slug, "#{repo.name}.git")
      assert_equal repo, Repository.find_by_path(path)
    end
    
    should_eventually "finds a repository by its path, regardless of repository kind" do
      repo = projects(:johans).wiki_repository
      path = File.join(GitoriousConfig['repository_base_path'].chomp("/"), 
                        projects(:johans).slug, "#{repo.name}.git")
      assert_equal repo, Repository.find_by_path(path)
    end
  
    should "finds a group repository by its path" do
      repo = repositories(:johans)
      repo.owner = groups(:team_thunderbird)
      repo.mainline = false
      repo.save!
      path = File.join(GitoriousConfig['repository_base_path'], repo.gitdir)
      assert_equal repo    , Repository.find_by_path(path)
    end
  
    should "finds a user repository by its path" do
      repo = repositories(:johans)
      repo.owner = users(:johan)
      repo.mainline = false
      repo.save!
      path = File.join(GitoriousConfig['repository_base_path'], repo.gitdir)
      assert_equal repo, Repository.find_by_path(path)
    end
  end
  
  should "xmlilizes git paths as well" do
    assert @repository.to_xml.include?("<gitdir>")
    assert @repository.to_xml.include?("<clone-url>")
    assert @repository.to_xml.include?("<push-url>")
  end
  
  should "knows if a user can write to self" do
    @repository.save!
    assert @repository.writable_by?(users(:johan)), '@repository.writable_by?(users(:johan)) should be true'
    assert !@repository.writable_by?(users(:mike)), '@repository.writable_by?(users(:mike)) should be false'
    
    @repository.owner = groups(:team_thunderbird)
    assert !@repository.writable_by?(users(:johan)), '@repository.writable_by?(users(:johan)) should be false'
    @repository.owner.add_member(users(:mike), Role.committer)
    assert @repository.writable_by?(users(:mike)), '@repository.writable_by?(users(:mike)) should be true'
    
    @repository.owner = users(:johan)
    assert @repository.writable_by?(users(:johan)), '@repository.writable_by?(users(:johan)) should be true'
    assert !@repository.writable_by?(users(:mike)), '@repository.writable_by?(users(:mike)) should be false'
  end
  
  should "publishes a message on create and update" do
    p = proc{
      @repository.save!
    }
    message = find_message_with_queue_and_regexp('/queue/GitoriousRepositoryCreation', /create_git_repository/) {p.call}
    assert_equal 'create_git_repository', message['command']
    assert_equal 1, message['arguments'].size
    assert_match(/#{@repository.real_gitdir}$/, message['arguments'].first)
    assert_equal @repository.id, message['target_id'].to_i
  end

  should "publishes a message on clone" do
    p = proc{
      @repository.parent = repositories(:johans)
      @repository.save!
    }
    message = find_message_with_queue_and_regexp('/queue/GitoriousRepositoryCreation', /clone_git_repository/) {p.call}
    assert_equal "clone_git_repository", message['command']
    assert_equal 2, message['arguments'].size
    assert_match(/#{@repository.real_gitdir}$/, message['arguments'].first)
    assert_equal @repository.id, message['target_id']
  end
  
  should "creates a notification on destroy" do
    @repository.save!
    message = find_message_with_queue_and_regexp(
      '/queue/GitoriousRepositoryDeletion', 
      /delete_git_repository/) { @repository.destroy }
    assert_equal 'delete_git_repository', message['command']
    assert_equal 1, message['arguments'].size
    assert_match(/#{@repository.real_gitdir}$/, message['arguments'].first)
  end
  
  should "has one recent commit" do
    @repository.save!
    repos_mock = mock("Git mock")
    commit_mock = stub_everything("Git::Commit mock")
    repos_mock.expects(:commits).with("master", 1).returns([commit_mock])
    @repository.stubs(:git).returns(repos_mock)
    @repository.stubs(:has_commits?).returns(true)
    heads_stub = mock("head")
    heads_stub.stubs(:name).returns("master")    
    @repository.stubs(:head_candidate).returns(heads_stub)
    assert_equal commit_mock, @repository.last_commit
  end
  
  should "has one recent commit within a given ref" do
    @repository.save!
    repos_mock = mock("Git mock")
    commit_mock = stub_everything("Git::Commit mock")
    repos_mock.expects(:commits).with("foo", 1).returns([commit_mock])
    @repository.stubs(:git).returns(repos_mock)
    @repository.stubs(:has_commits?).returns(true)   
    @repository.expects(:head_candidate).never
    assert_equal commit_mock, @repository.last_commit("foo")
  end
  
  should "knows who can delete it" do
    @repository.mainline = true
    assert !@repository.can_be_deleted_by?(users(:johan)), '@repository.can_be_deleted_by?(users(:johan)) should be false'
    @repository.mainline = false
    assert !@repository.can_be_deleted_by?(users(:moe)), '@repository.can_be_deleted_by?(users(:moe)) should be false'
    assert @repository.can_be_deleted_by?(users(:johan)), '@repository.can_be_deleted_by?(users(:johan)) should be true'
  end
  
  should "have a git method that accesses the repository" do
    # FIXME: meh for stubbing internals, need to refactor that part in Grit
    File.expects(:exist?).at_least(1).with("#{@repository.full_repository_path}/.git").returns(false)
    File.expects(:exist?).at_least(1).with(@repository.full_repository_path).returns(true)
    assert_instance_of Grit::Repo, @repository.git
    assert_equal @repository.full_repository_path, @repository.git.path
  end
  
  should "have a head_candidate" do
    heads_stub = mock("head")
    heads_stub.stubs(:name).returns("master")
    git = mock("git backend")
    @repository.stubs(:git).returns(git)
    git.expects(:heads).returns([heads_stub])
    @repository.expects(:has_commits?).returns(true)
    assert_equal heads_stub, @repository.head_candidate
    
    heads_stub = mock("head")
    heads_stub.stubs(:name).returns("foo/bar")
    @repository.expects(:head_candidate).returns(heads_stub)
    assert_equal "foo/bar", @repository.head_candidate_name
  end
  
  should "have a head_candidate, unless it doesn't have commits" do
    @repository.expects(:has_commits?).returns(false)
    assert_equal nil, @repository.head_candidate
  end
  
  should "has paginated_commits" do
    git = mock("git")
    commits = [mock("commit"), mock("commit")]
    @repository.expects(:git).times(2).returns(git)
    git.expects(:commit_count).returns(120)
    git.expects(:commits).with("foo", 30, 30).returns(commits)
    commits = @repository.paginated_commits("foo", 2, 30)
    assert_instance_of WillPaginate::Collection, commits
  end
  
  should "has a count_commits_from_last_week_by_user of 0 if no commits" do
    @repository.expects(:has_commits?).returns(false)
    assert_equal 0, @repository.count_commits_from_last_week_by_user(users(:johan))
  end
  
  should "returns a set of users from a list of commits" do
    commits = []
    users(:johan, :moe).map do |u|
      committer = OpenStruct.new(:email => u.email)
      commits << OpenStruct.new(:committer => committer, :author => committer)
    end
    users = @repository.users_by_commits(commits)
    assert_equal users(:johan, :moe).map(&:email).sort, users.keys.sort
    assert_equal users(:johan, :moe).map(&:login).sort, users.values.map(&:login).sort
  end
  
  should "know if it's a normal project repository" do
    assert @repository.project_repo?, '@repository.project_repo? should be true'
  end
  
  should "know if it's a wiki repo" do
    @repository.kind = Repository::KIND_WIKI
    assert @repository.wiki?, '@repository.wiki? should be true'
  end
  
  should "has a parent, which is the owner" do
    @repository.owner = groups(:team_thunderbird)
    assert_equal groups(:team_thunderbird), @repository.breadcrumb_parent
    @repository.owner = users(:johan)
    assert_equal users(:johan), @repository.breadcrumb_parent
    @repository.owner = projects(:johans)
    assert_equal projects(:johans), @repository.breadcrumb_parent
  end
  
  should "has a parent, which is the project for mainlines" do
    @repository.mainline = true
    @repository.owner = groups(:team_thunderbird)
    assert_equal projects(:johans), @repository.breadcrumb_parent
    @repository.owner = users(:johan)
    assert_equal projects(:johans), @repository.breadcrumb_parent
    @repository.owner = projects(:johans)
    assert_equal projects(:johans), @repository.breadcrumb_parent
    @repository.mainline = false
    @repository.owner = projects(:johans)
    assert_equal projects(:johans), @repository.breadcrumb_parent
  end
  
  should " return its name as title" do
    assert_equal @repository.title, @repository.name
  end
  
  should "returns a list of committers depending on owner type" do
    repo = repositories(:johans2)
    
    repo.owner = projects(:johans)
    assert_equal [users(:johan)], repo.committers
    
    repo.owner = users(:johan)
    assert_equal [users(:johan)], repo.committers
    
    repo.owner = groups(:team_thunderbird)
    assert_equal groups(:team_thunderbird).members, repo.committers
    
    repo.owner.add_member(users(:moe), Role.committer)
    repo.reload
    assert repo.committers.map(&:login).include?(users(:moe).login)
  end
  
  should "sets a hash on create" do
    assert @repository.new_record?, '@repository.new_record? should be true'
    @repository.save!
    assert_not_equal nil, @repository.hashed_path
    assert_match(/[a-z0-9]{40}/, @repository.hashed_path)
  end
  
  should "know the full hashed path" do
    @repository.hashed_path = "a"*40
    assert_equal "aaa/aaa/#{'a'*34}", @repository.full_hashed_path
  end
  
  should " allow changing ownership from a user to a group" do
    repo = repositories(:johans)
    repo.change_owner_to(groups(:team_thunderbird))
    assert_equal groups(:team_thunderbird), repo.owner
    repo.change_owner_to(users(:johan))
    assert_equal groups(:team_thunderbird), repo.owner
  end
  
  should "downcases the name before validation" do
    repo = new_repos(:name => "FOOBAR")
    repo.save!
    assert_equal "foobar", repo.reload.name
  end
  
  context "participant groups" do
    setup do
      @repo = repositories(:moes)
    end
    
    should "has a set of groups" do
      assert_equal [groups(:team_thunderbird)], @repo.groups
    end
    
    should "collects all the groups' members" do
      assert_equal groups(:team_thunderbird).members, @repo.group_members
    end
    
    should "includes the groups' members in #committers" do
      assert @repo.committers.include?(groups(:team_thunderbird).members.first)
    end
    
    should "only include unique users in #committers" do
      groups(:team_thunderbird).add_member(users(:moe), Role.committer)
      assert_equal 1, @repo.committers.select{|u| u == users(:moe)}.size
    end
    
    should " be possible to exclude the groups in #committers" do
      users = @repo.committers(:exclude_groups => true).map(&:login)
      assert !users.include?(groups(:team_thunderbird).members.first.login)
    end
  end
  
  context "observers" do
    should "sends an email to the admin if there's a parent" do
      Mailer.expects(:deliver_new_repository_clone).with(@repository).returns(true)
      @repository.parent = repositories(:johans)
      @repository.save!
    end
    
    should "does not send an email to the admin if there's not a parent parent" do
      Mailer.expects(:deliver_new_repository_clone).never
      @repository.parent = nil
      @repository.save!
    end
  end
end