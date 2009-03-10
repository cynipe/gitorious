# encoding: utf-8
{
  :'en' => {
    :application => {
      :require_ssh_keys_error => "You need to upload your public key first",
      :require_current_user => "Bad {{title}}, bad! You shouldn't be snooping around in other people's stuff!",
      :no_commits_notice => "The repository doesn't have any commits yet",
    },
    :admin => {
      :users_controller => {
        :create_notice => 'User was successfully created.',
        :suspend_notice => "User {{user_name}} was successfully suspended.",
        :suspend_error => "Unable to suspend user {{user_name}}.",
        :unsuspend_notice => "User {{user_name}} was successfully unsuspended.",
        :unsuspend_error => "Unable to unsuspend user {{user_name}}.",
        :check_admin => "For Administrators Only",
      },
    },
    :mailer => {
      :repository_clone => "{{login}} has cloned {{slug}}/{{parent}}",
      :request_notification => "{{login}} has requested a merge in {{title}}",
      :new_password => "Your new password",
      :subject  => 'Please activate your new account',
      :activated => 'Your account has been activated!',
    },
    :blobs_controller => {
      :raw_error => "Blob is too big. Clone the repository locally to see it",
    },
    :comments_controller => {
      :create_success => "Your comment was added",
    },
    :committers_controller => {
      :create_error_not_found => "Could not find user by that name",
      :create_error_already_commiter => "Could not add user or user is already a committer",
      :destroy_success => "User removed from repository",
      :destroy_error => "Could not remove user from repository",
      :find_repository_error => "You're not the owner of this repository",
    },
    :keys_controller => {
      :create_notice => "Key added",
      :destroy_notice => "Key removed",
    },
    :merge_requests_controller => {
      :create_success => "You sent a merge request to \"{{name}}\"",
      :resolve_notice => "The merge request was marked as {{status}}",
      :resolve_disallowed => "The merge request could not be marked as {{status}}",
      :update_success => "Merge request was updated",
      :destroy_success => "Merge request was retracted",
      :assert_resolvable_error => "You're not permitted to resolve this merge request",
      :assert_ownership_error => "You're not the owner of this merge request",
      :need_contribution_agreement => "You need to accept the contribution agreement"
    },
    :projects_controller => {
      :update_error => "You're not the owner of this project",
      :destroy_error => "You're not the owner of this project, or the project has clones",
      :create_only_for_site_admins => "Only site administrators are allowed to create new projects",
    },
    :repositories_controller => {
      :new_clone_error => "Sorry, can't clone an empty repository",
      :create_clone_error => "Sorry, can't clone an empty repository",
      :create_success => "New repository created",
      :destroy_notice => "The repository was deleted",
      :destroy_error => "You're not the owner of this repository",
      :adminship_error => "Sorry, only repository admins are allowed to do that",
      :only_projects_create_new_error => "You can only add new repositories directly to a project",
    },
    :trees_controller => {
      :archive_error => "The given repository or sha is invalid"
    },
    :users_controller => {
      :create_notice => "Thanks for signing up! You will receive an account activation email soon",
      :activate_notice => "Your account has been activated, welcome!",
      :activate_error => "Invalid activation code",
      :reset_password_notice => "A new password has been sent to your email",
      :reset_password_error => "Invalid email",
    },
    :pages_controller => {
      :invalid_page_error => "invalid page, badly formatted title or body",
      :no_changes => "No changes was submitted",
      :repository_not_ready => "The wiki is being created",
    },
    :memberships_controller => {
      :membership_created => "Membership was successfully created",
      :membership_updated => "Membership was updated",
      :failed_to_destroy => "Failed to destroy membership",
      :membership_destroyed => "Membership deleted",
    },
    :application_helper => {
      :notice_for => lambda { |class_name| "This #{class_name} is being created,<br /> it will be ready pretty soon&hellip;"},
      :event_status_add_project_repository => "added repository",
      :event_status_created => "created project",
      :event_status_deleted => "deleted project",
      :event_status_updated => "updated project",
      :event_status_cloned => "cloned",
      :event_status_deleted => "deleted",
      :event_status_pushed => "pushed",
      :event_status_started => "started development",
      :event_branch_created => "created branch",
      :event_branch_deleted => "deleted branch",
      :event_tagged => "tagged",
      :event_tag_deleted => "deleted tag",
      :event_committer_added => "added committer",
      :event_committer_removed => "removed committer",
      :event_commented => "commented",
      :event_requested_merge_of => "requested merge of",
      :event_resolved_merge_request => "resolved merge request",
      :event_updated_merge_request => "updated merge request",
      :event_deleted_merge_request => "deleted merge request",
      :event_status_push_wiki => "pushed wiki content",
      :event_updated_wiki_page => "edited wiki page",
      :event_status_pushed => 'pushed some commits',
      :event_status_committed => 'committed',
      :event_pushed_n => "pushed {{commit_link}}",
      :more_info => "More info…",
    },
    :project => {
      :format_slug_validation => "must match something in the range of [a-z0-9_\-]+",
      :ssl_required => "Must begin with http(s)",
    },
    :user => {
      :invalid_url => "Invalid url",
    },
    :views => {
      :layout => {
        :system_notice => "System notice",
        :home => "Home",
        :dashboard => "Dashboard",
        :admin => "Administration",
        :projects => "Projects",
        :search => "Search",
        :faq => "FAQ",
        :about => "About",
        :my_account => "My Account",
        :logout => "Logout",
        :login => "Login",
        :register => "Register",
        :project_overview => "Project Overview",
        :repositories => "Repositories",
        :pages => "Wiki",
        :user_mgt => "User Management",
        :discussion => "Discussion group",
        :teams => "Teams"
      },
      :site => {
        :page_title => "Free open source project hosting",
        :description => "<strong>Gitorious</strong> aims to provide a great\nway of doing distributed opensource code collaboration",
        :for_projects => "For Projects",
        :for_contributors => "For Contributors",
        :creating_account => lambda { |this, path| 
          this.link_to("Creating a user account", path) + 
          " allows you to create your own project or participate in the development of any project." },
        :newest_projects => "Newest projects",
        :view_more => "View more &raquo;",
        :dashboard => {
          :page_title => "{{login}}'s dashboard",
          :activities => "Activities",
          :your_projects => "Your projects:",
          :your_clones => "Your repository clones",
          :your_account => "Your Account",
          :your_profile => "Your Profile",
          :projects => "Projects",
          :clones => "Repository clones",
        },
      },
      :events => {
        :page_title => "Events",
        :activities => "Gitorious activities",
        :system_activities => "System Activities",
      },
      :license => {
        :show_title => 'End User License Agreement',
        :terms_accepted => 'You have accepted the current End User License Agreement',
        :terms_not_accepted => 'You need to accept the current End User License Agreement',
        :terms_already_accepted => 'You have already accepted the latest agreement'
      },
      :keys => {
        :edit_title => "Edit a SSH key",
        :ssh_keys => "Your SSH Keys",
        :manage_ssh_keys => "Manage SSH keys",
        :add_ssh_key => "Add SSH key",
        :add_title => "Add a new public SSH key",
        :your_public_key => "Your public key",
        :hint => "It's generally located in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub. If you want to use multiple keys you'll have to add each of them seperately. <br />The key should be in the format of: <br /><code>ssh-algorithm base64-content you@somehost</code>",
      },
      :users => {
        :activated => "Activated?",
        :suspended => "Suspended?",
        :reset_pwd => "Reset Password",
        :admin => "Admin?",
        :suspend => "Suspend",
        :unsuspend => "Unsuspend",
        :create_btn => "Create New User",
        :is_admin => "Is Administrator?",
        :forgot_title => "Forgot your password?",
        :send_new_passwd => 'Send me a new password',
        :create_title => lambda { |this, path| "Create new user or " + 
          this.link_to( "login directly with your OpenID", path ) },
        :create_description => "Creating a user account allows you to create your own project or participate in the development of any project.",
        :wants_email_notifications => 'Send email notifications?',
        :describe_email_notifications => "We will send you an email notification when you receive a message in Gitorious",
        :member_for => "Member for",
        :this_week => {
          :one => "commit so far this week",
          :other => "commits so far this week",
        },
        :about => "about {{about}}",
	:edit_title => "Edit account details",
        :realname => "Realname",
        :url => "url <small>blog etc</small>",
        :openid => "OpenID",
        :my_account => "My account",
        :chg_passwd => "Change password",
        :new_passwd => "New password",
        :new_passwd_conf => "New password confirmation",
        :edit_details => "Edit details",
        :show_title => "Account",
        :details_title => "Account details",
        :edit_link => "edit",
        :username => "Username",
        :create => "create an account",
        :license => 'End User License Agreement'
      },
      :logs => {
        :page_title => "Commits in {{repo}} in {{title}}",
        :commitlog => "Commitlog for {{repo}}:{{param}} in {{title}}",
        :project => "Project",
        :maintainer => "Maintainer",
        :head_tree => "HEAD tree",
        :branches => "Branches",
        :tags => "Tags",
        :committed => "committed",
      },
      :blobs => {
        :page_title => "{{path}} - {{repo}} in {{title}}",
        :wrap => "Softwrap mode",
        :title => "Blob of <code>{{path}}</code>",
        :raw => "raw blob data",
        :too_big => lambda { |this, path| "This file is too big to be rendered within reasonable time, " +
          this.link_to("try viewing the raw data", path) },
        :message => lambda { |this, mime, path| "Not sure we can display this blob nicely (it's a \"#{mime}\" mimetype), " +
          this.link_to("try viewing the raw data", path) + 
          "and see if your browser figures it out." },
      },
      :comments => {
        :commit => "on commit {{sha1}}",
        :permalink => '<abbr title="permalink for this comment">#</abbr>',
        :add_title => "Add a new comment",
        :body => "Comment",
        :add => "Add Comment",
        :page_title => "Comments in {{repo}}",
        :diff => "Commit diff",
        :total => "Comments ({{total}})",
        :page_title_2 => "Comments on {{title}}",
        :page_title_3 => "Comments for &quot;{{repo}}&quot; repository in {{title}}",
      },
      :commits => {
        :date => "Date",
        :committer => "Committer",
        :author => "Author",
        :sha1 => "Commit SHA1",
        :tree_sha1 => "Tree SHA1",
        :parent_sha1 => "Parent SHA1",
        :page_title => "Commit in {{repo}} in {{title}}",
        :title => "Commit {{commit}}",
        :message => lambda { |this, path| "This is the initial commit in this repository, " +
          this.link_to( "browse the initial tree state", path ) + "." },
      },
      :sessions => {
        :login => "Login",
        :label => lambda { |this| "Email or #{this.switch_login('switch to OpenID','to_openid')}" },
        :passwd => "Password",
        :openid => lambda { |this| "OpenID or #{this.switch_login('switch to email login', 'to_email')}"},
        :remember => "Remember me",
        :submit => 'Log in',
        :register => "Register",
        :forgot => "Forgotten your password?",
      },
      :searches => {
        :search => "Search",
        :hint => %Q{eg. 'wrapper', 'category:python' or '"document database"'},
        :page_title => %Q{Search for "{{term}}"},
        :no_results => "Sorry, no results for {{term}}",
        :found => {
          :one => "Found {{count}} result in {{time}}ms",
          :other => "Found {{count}} results in {{time}}ms",
        },
      },
      :trees => {
        :page_title => "Tree for {{repo}} in {{title}}",
        :title => "Tree of {{repo}} repository in {{title}}",
        :download => "Download as gzipped tarball",
        :branch => "Branch",
      },
      :repos => {
        :overview => "Overview",
        :commits => "Commits",
        :tree => "Source Tree",
        :comments => "Comments ({{count}})",
        :requests => "Merge requests ({{count}})",
        :public_url => "Public clone url",
        :more_info => "More info…",
        :help_clone => "You can clone this repository with the following command",
        :help_clone_http => "note that cloning over HTTP is slightly slower, but useful if you're behind a firewall",
        :http_url => "HTTP clone url",
        :push_url => "Push url",
        :help_push => lambda { |repo| "You can run \"<code>git push #{repo}</code>\", or you can setup a remote by doing the following:" },
        :owner => "Owner",
        :creator => "creator",
        :project => "Project",
        :confirm_delete => "Please confirm deletion of {{repo}} in {{title}}",
        :message_delete => "Once you press this button the repository will be deleted",
        :btn_delete => "YES I am sure I want to delete this repository permanently",
        :page_title => "Repositories in {{repo}}",
        :title => "Repositories",
        :commits => "Commits",
        :tree => "Tree",
        :activities => { :one => "activity", :other => "activities" },
        :branches => { :one => "branch", :other => "branches" },
        :authors => { :one => "author", :other => "authors" },
        :name => %Q{Name <small>(eg "{{name}}-sandbox", "performance-fixes" etc)</small>},
        :btn_clone => "Clone this repository on Gitorious",
        :back => "Back to repository",
        :show_page_title => "{{repo}} in {{title}}",
        :show_title => "&quot;{{repo}}&quot; repository in {{title}}",
        :committers_title => "Add committers to {{repo}} in {{title}}",
        :committers_manage_group_members => "Manage group members for {{group}}",
        :committers_howto => "There are two ways to add committers to a repository, either by adding 
                              members to the group owning the repository, or to add another group as 
                              committers.",
        :transfer_owner => "Transfer owner",
        :current_owner_project => "The repository is currrently owned by the {{project_name}} project (which you own).",
        :current_owner_user => "The repository is currrently owned by you.",
        :transfer_owner_howto => "If you wish, you can transfer ownership
                                  of this repository to a group you're an administrator of. That way you can add
                                  multiple users as committers, without requiring them to start a group.",
        :add_committer_group => "Or you can add an existing group as committers to the repository, 
                                thus giving all the members commit access.",
        :activities => "Activities",
        :clone_of => "Clone of",
        :created => "Created",
        :btn_request => "Request merge",
        :btn_add_committer => "Add committer",
        :btn_add_committers => "Add committers",
        :btn_manage_committers => "Manage committers",
        :btn_delete_repo => "Delete repository",
        :btn_edit_repo => "Edit repository",
        :committers => "Committers",
        :current_committers => "Current committers",
        :remove => "Remove",
        :create_title => lambda { |this, clone, project| 
          "Create a clone of #{this.link_to(this.send(:h, clone.name), this.send(:project_repository_path, project, clone) )} <small>in #{this.link_to this.send(:h, project.title), this.send(:project_path, project)}</small>"
        },
        :edit_group => "Edit/show group members",
        :show_group => "Show group members",
        :by_teams => "Teams",
        :by_users => "Personal",
      },
      :projects => {
        :title => "Projects",
        :back => "Back to edit screen",
        :hint => %Q{<a href="http://daringfireball.net/projects/markdown/">Markdown</a> and basic html is allowed},
        :categories => "Categories",
        :delete => "Delete project",
        :delete_title => "Please confirm deletion of {{title}}",
        :delete_message => "Once you press this button the project will be deleted",
        :delete_btn => "YES I am sure I want to delete this project permanently",
        :edit => "Edit project",
        :update_title => "Update {{link}}",
        :new => "New project",
        :popular => "Popular Categories",
        :new_title => "Create a new project",
        :new_hint => "After you've created the project you'll have the option of adding one or more repositories to the project.",
        :create => "Create project",
        :settings => "Project Settings",
        :labels => "Labels",
        :license => "License",
        :owner => "Owner",
        :created => "Created",
        :website => "Website at ",
        :mailing => "Mailinglist at ",
        :bugtracker => "Bugtracker at ",
        :repos => "Repositories",
        :project_members => "Project members",
        :add_repository => "Add mainline repository"
      },
      :merges => {
        :info => {
          :target_repos => "The one you wish this repository should be merged with",
          :target_branch => "The target branch you wish your changes to be merged into",
          :source_branch => "The source branch you wish the target repository should merge from",
          :proposal => "A short summary of your changes",          
        },
        :summary_title => "{{source}} has requested a merge with {{target}}",
        :review => "Review merge request &#x2192;",
        :page_title => "Merge requests in {{repo}}",
        :hint => %Q{A "merge request" is a notification from one repository to another that would like their changes to be merged upstream.},
        :no_merge => "No merge requests yet",
        :create_title => "Create a merge request",
        :create_btn => "Create merge request",
        :show_title => "Reviewing merge request {{source}} &#x2192; {{target}}",
        :update_btn => "Update merge request",
        :help => "The recommended way to merge in these changes is to pull them into a local branch for review and them merge to back to master:",
        :commits => "Commits that would be merged",
      },
      :committers => {
        :title => "Give a user commit rights to {{repo}}",
        :login => "Existing username <small>(search-as-you-type)</small>",
        :add => "Add as committer",
      },
      :common => {
        :confirm => "Are you sure?",
        :create => "Create",
        :creating => "Creating",
        :editing => "Editing",
        :edit => "Edit",
        :save => "Save",
        :delete => "delete",
        :add => "Add",
        :yes => "Yes",
        :no => "No",
        :back => "Back",
        :signup => 'Sign up',
        :toggle => "Toggle",
        :none => "none",
        :update => "Update",
        :cancel => "cancel",
        :or => "or",
        :remove => "remove",
        :format_using_markdown => %Q(Use {{markdown}} for formatting),
      },
      :pages => {
        :page => "page",
        :last_edited_by => "Last edited by {{link_or_name}}",
        :or_back_to_page => "or return to {{page_link}}",
        :history => "History",
        :last_n_edits => "Last {{n}} edits on {{title}}",
        :index => "Pages index",
        :format_using_markdown => %Q(Format pages using {{markdown}}),
        :wikiwords_syntax => "[[Wikilink]] will be linked to a page of that name."
      },
      :memberships => {
        :add_new_member => "Add new member",
        :role => "Role",
        :header_title => "Members in {{group_name}}",
        :new_title => "Add new member to {{group_memberships}}",
      },
      :groups => {
        :create_team => "Create a new team",
        :team_name => "Team name",
        :project_name => "Project name",
        :create_team_submit => "Create team",
        :teams => "Teams",
        :member_singular => "member",
        :member_plural => "members",
        :repo_singular => "repository",
        :repo_plural => "repositories",
        :new_team_after_create_hint => "You can add more members to the team, after you've created it",
        :edit_memberships => "Edit memberships",
      },
      :committerships => {
        :add_new => "Add committers",
        :title => "Users &amp; teams with commit rights to {{repo_name}}",
        :committer_name => "Committer",
        :group_name => "Team name",
        :user_login => "Username",
        :add_user_instead => "Add a user instead",
        :add_team_instead => "Add a team instead",
        :new_title => "Add a user or team as committers to {{repo_name}}",
        :btn_add_as_committer => "Add as committers",
        :return_to => "return to", 
        :or_return_to => "or return to", 
        :add_tema_note => "<strong>Note</strong> that adding a team will give
                          everyone in that team commit rights to your repository",
      },
      :emails => {
        :aliases_title => "Email aliases",
        :new_alias => "New email alias",
        :manage_emails => "Manage email aliases"
      },
      :messages => {
        :collection_title => "Messages",
        :title_new  => "Compose a message",
        :subject  => "Subject",
        :body => "Message body",
        :recipient => "Choose a recipient",
        :submit => "Send message",
        :index_message => "Your inbox",
        :reply => "Reply",
        :received_messages => "Inbox",
        :sent_messages => "Sent messages",
        :new => "Compose a message",
        :mark_as_read => "Mark as read"
      }
    },
    :date => {
      :formats => {
        :long_ordinal => lambda { |date| "%B #{date.day.ordinalize}, %Y" },
        :default => "%Y-%m-%d",
        :short => "%e %b",
        :long => "%B %e, %Y",
        :only_day => "%e",
      },
      :day_names => %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday),
      :abbr_day_names => %w(Sun Mon Tue Wed Thu Fri Sat),
      :month_names => [nil] + %w(January February March April May June July August September October November December),
      :abbr_month_names => [nil] + %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec),
      :order => [ :year, :month, :day ],
    },
    :time => {
      :formats => {
        :long_ordinal => lambda { |time| "%B #{time.day.ordinalize}, %Y %H:%M" },
        :default => "%a %b %d %H:%M:%S %Z %Y",
        :time => "%H:%M",
        :short => "%d %b %H:%M",
        :long => "%B %d, %Y %H:%M",
        :only_second => "%S",
        :human => "%A %B %d",
        :short_time => "%H:%M",
        :datetime => {
          :formats => {
            :default => "%Y-%m-%dT%H:%M:%S%Z",
          },
        },
      },
      :time_with_zone => {
        :formats => {
          :default => lambda { |time| "%Y-%m-%d %H:%M:%S #{time.formatted_offset(false, 'UTC')}" }
        },
      },
      :am => 'AM',
      :pm => 'PM',
    },
    :activerecord => {
      :models => {
        :comment => "Comment",
        :event => "Event",
        :group => "Team",
        :membership => "Membership",
        :merge_request => "Merge Request",
        :project => "Project",
        :repository => "Repository",
        :role => "Role",
        :ssh_key => "SSH Key",
        :tags => "Category",
        :user => "User",
      },
      :attributes => {
        :user => {
          :login => "Login",
          :email => "Email",
          :current_password => "Current Password",
          :password => "Password",
          :password_confirmation => "Password Confirmation",
          :eula => 'End User License Agreement',
          :created_at => "Created At",
          :updated_at => "Updated At",
          :activation_code => "Activation Code",
          :activated_at => "Activated At",
          :fullname => "Full name",
          :url => "Url",
          :public_email => "Show email in public?"
        },
        :merge_request => {
          :target_repository_id => "Target Repository",
          :proposal => "Proposal",
          :source_branch => "Source Branch",
          :target_branch => "Target Branch",
        },
        :project => {
          :title => "Title",
          :description => "Description (obligatory)",
          :slug => "Slug (for urls etc)",
          :license => "License",
          :home_url => "Home URL (if any)",
          :mailinglist_url => "Mailinglist URL (if any)",
          :bugtracker_url => "Bugtracker URL (if any)",
          :wiki_enabled => "Should the wiki be enabled?",
          :tag_list => "Categories (space seperated)",
        },
        :comment => {
          :body => "Body",
        },
        :repository => {
          :name => "Name",
          :ready => "Ready",
        },
        :keys => {
          :key => "Key",
          :ready => "Ready",
        },
        :roles => {
          :name => "Role"
        },
        :memberships => {
          :created_at => "Created at"
        },
        :committerships => {
          :created_at => "Created at",
          :committer => "committer",
          :committer_type => "Committer type",
          :repository => "Repository",
          :creator => "Added by",
        }
      },
    }
  }
}
