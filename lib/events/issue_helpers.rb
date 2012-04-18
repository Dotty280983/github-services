module Service::IssueHelpers
  include Service::HelpersWithRepo,
    Service::HelpersWithActions

  def issue
    @issue ||= self.class.objectify(payload['issue'])
  end

  def summary_url
    issue.html_url
  end

  def summary_message
    "[%s] %s %s issue #%d: %s. %s" % [
      repo.name,
      issue.user.login,
      action,
      issue.number,
      issue.title,
      issue.html_url]
  rescue
    raise_config_error "Unable to build message: #{$!.to_s}"
  end

  def self.sample_payload
    {
      "action" => "opened",
      "issue" => {
        "number" => 5,
        "state" => "open",
        "title" => "booya",
        "body"  => "boom town",
        "user" => { "login" => "mojombo" }
      },
      "repository" => {
        "name"  => "grit",
        "url"   => "http://github.com/mojombo/grit",
        "owner" => { "login" => "mojombo" }
      }
    }
  end
end
