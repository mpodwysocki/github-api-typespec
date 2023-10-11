import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace GitHub;

model RootResponse {
  @projectedName("json", "current_user_url")
  currentUserUrl: url;

  @projectedName("json", "current_user_authorizations_html_url")
  currentUserAuthorizationsHtmlUrl: url;

  @projectedName("json", "authorizations_url")
  authorizationsUrl: url;

  @projectedName("json", "code_search_url")
  codeSearchUrl: url;

  @projectedName("json", "commit_search_url")
  commitSearchUrl: url;

  @projectedName("json", "emails_url")
  emailsUrl: url;

  @projectedName("json", "emojis_url")
  emojisUrl: url;

  @projectedName("json", "events_url")
  eventsUrl: url;

  @projectedName("json", "feeds_url")
  feedsUrl: url;

  @projectedName("json", "followers_url")
  followersUrl: url;

  @projectedName("json", "following_url")
  followingUrl: url;

  @projectedName("json", "gists_url")
  gistsUrl: url;

  @projectedName("json", "hub_url")
  hubUrl: url;

  @projectedName("json", "issue_search_url")
  issueSearchUrl: url;

  @projectedName("json", "issues_url")
  issuesUrl: url;

  @projectedName("json", "keys_url")
  keysUrl: url;

  @projectedName("json", "label_search_url")
  labelSearchUrl: url;

  @projectedName("json", "notifications_url")
  notificationsUrl: url;

  @projectedName("json", "organization_url")
  organizationUrl: url;

  @projectedName("json", "organization_repositories_url")
  organizationRepositoriesUrl: url;

  @projectedName("json", "organization_teams_url")
  organizationTeamsUrl: url;

  @projectedName("json", "public_gists_url")
  publicGistsUrl: url;

  @projectedName("json", "rate_limit_url")
  rateLimitUrl: url;

  @projectedName("json", "repository_url")
  repositoryUrl: url;

  @projectedName("json", "repository_search_url")
  repositorySearchUrl: url;

  @projectedName("json", "current_user_repositories_url")
  currentUserRepositoriesUrl: url;

  @projectedName("json", "starred_url")
  starredUrl: url;

  @projectedName("json", "starred_gists_url")
  starredGistsUrl: url;

  @projectedName("json", "topic_search_url")
  topicSearchUrl?: url;

  @projectedName("json", "user_url")
  userUrl: url;

  @projectedName("json", "user_organizations_url")
  userOrganizationsUrl: url;

  @projectedName("json", "user_repositories_url")
  userRepositoriesUrl: url;

  @projectedName("json", "user_search_url")
  userSearchUrl: url;
}
