import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace GitHub;

@doc("A GitHub Security Advisory.")
model GlobalAdvisory {
  @doc("The GitHub Security Advisory ID.")
  @projectedName("json", "ghsa_id")
  ghsaId: string;

  @doc("The Common Vulnerabilities and Exposures (CVE) ID.")
  @projectedName("json", "cve_id")
  cveId?: string;

  @doc("The API URL for the advisory.")
  url: url;

  @doc("The URL for the advisory.")
  @projectedName("json", "html_url")
  htmlUrl: url;

  @doc("The API URL for the repository advisory.")
  @projectedName("json", "repository_advisory_url")
  repositoryAdvisoryUrl?: url;

  @doc("A short summary of the advisory.")
  @maxLength(1024)
  summary: string;

  @doc("A detailed description of what the advisory entails.")
  @maxLength(65535)
  description?: string;

  @doc("The type of advisory.")
  type: AdvisoryType;

  @doc("The severity of the advisory.")
  severity: AdvisorySeverity; // TODO: Check the values

  @doc("The URL of the advisory's source code.")
  @projectedName("json", "source_code_location")
  sourceCodeLocation?: string;

  @doc("The advisory identifiers")
  identifiers: GlobalAdvisoryIdentifier[];

  @doc("URLs with more information regarding the advisory.")
  references: string[];

  @doc("The date and time of when the advisory was published, in ISO 8601 format.")
  @projectedName("json", "published_at")
  publishedAt: utcDateTime;

  @doc("The date and time of when the advisory was last updated, in ISO 8601 format.")
  @projectedName("json", "updated_at")
  updatedAt: utcDateTime;

  @doc("The date and time of when the advisory was reviewed by GitHub, in ISO 8601 format.")
  @projectedName("json", "github_reviewed_at")
  githubReviewedAt?: utcDateTime;

  @doc("The date and time when the advisory was published in the National Vulnerability Database, in ISO 8601 format.\nThis field is only populated when the advisory is imported from the National Vulnerability Database.")
  @projectedName("json", "nvd_published_at")
  nvdPublishedAt?: utcDateTime;

  @doc("The date and time of when the advisory was withdrawn, in ISO 8601 format.")
  @projectedName("json", "withdrawn_at")
  withdrawnAt?: utcDateTime;

  @doc("The products and respective version ranges affected by the advisory.")
  vulnerabilities?: AdvisoryVulnerability[];

  @doc("The CVSS associated with this advisory")
  cvss?: CVSS[];

  @doc("The Common Weakness Enumerations associated with this advisory")
  cwes?: CWE[];

  @doc("The users who contributed to the advisory.")
  credits?: AdvisoryCredit[];
}

model AdvisoryCredit {
  user: SimpleUser;
  type: SecurityAdvisoryCreditTypes
}

@doc("The type of credit the user is receiving.")
enum SecurityAdvisoryCreditTypes {
  Analyst: "analyst",
  Finder: "finder",
  Reporter: "reporter",
  Coordinator: "coordinator",
  RemediationDeveloper: "remediation_developer",
  RemediationReviewer: "remediation_reviewer",
  RemediationVerifier: "remediation_verifier",
  Tool: "tool",
  Sponsor: "sponsor",
  Other: "other"
}

@doc("Simple User")
model SimpleUser {
  name?: string;
  email?: string;
  login: string;
  id: int32;
  @projectedName("json", "node_id") nodeId: string;
  @projectedName("json", "avatar_url") avatarUrl: url;
  @projectedName("json", "gravatar_id") gravatarId?: string;
  url: url;
  @projectedName("json", "html_url") htmlUrl: url;
  @projectedName("json", "followers_url") followersUrl: url;
  @projectedName("json", "following_url") followingUrl: url;
  @projectedName("json", "gists_url") gistsUrl: url;
  @projectedName("json", "starred_url") starredUrl: url;
  @projectedName("json", "subscriptions_url") subscriptionsUrl: url;
  @projectedName("json", "organizations_url") organizationsUrl: url;
  @projectedName("json", "repos_url") reposUrl: url;
  @projectedName("json", "events_url") eventUrl: url;
  @projectedName("json", "received_events_url") receivedEventsUrl: url;
  type: string;
  @projectedName("json", "site_admin") siteAdmin: boolean;
  @projectedName("json", "starred_at") starredAt?: utcDateTime;
}

model CWE {
  @doc("The Common Weakness Enumeration (CWE) identifier.")
  @projectedName("json", "cwe_id")
  cweId: string;

  @doc("The name of the CWE.")
  name: string;
}

model CVSS {
  @doc("The CVSS vector.")
  @projectedName("json", "vector_string")
  vectorString?: string;

  @doc("The CVSS score.")
  @minValue(0)
  @maxValue(10)
  score?: int32;
}

@doc("The package's language or package management ecosystem.")
enum SecurityAdvisoryEcosystem {
  RubyGems: "rubygems",
  NPM: "npm",
  Pip: "pip",
  Maven: "maven",
  NuGet: "nuget",
  Composer: "composer",
  Go: "go",
  Rust: "rust",
  Erlang: "erlang",
  Actions: "actions",
  Pub: "pub",
  Other: "other",
  Swift: "swift"
}

model AdvisoryVulnerability {
  @doc("The name of the package affected by the vulnerability.")
  package: {
    @doc("The unique package name within its ecosystem.")
    name: string;

    @doc("The package's language or package management ecosystem.")
    ecosystem: SecurityAdvisoryEcosystem;
  };

  @doc("The range of the package versions affected by the vulnerability.")
  @projectedName("json", "vulnerable_version_range")
  vulnerableVersionRange?: string;

  @doc("The package version that resolve the vulnerability.")
  @projectedName("json", "first_patched_version")
  firstPatchedVersion?: string;

  @doc("The functions in the package that are affected by the vulnerability.")
  @projectedName("json", "vulnerable_functions")
  vulnerableFunctions?: string[];
}

model GlobalAdvisoryIdentifier {
  type: GlobalAdvisoryIdentifierType;
  value: string;
}

enum GlobalAdvisoryIdentifierType {
  CVE: "CVE",
  GHSA: "GHSA"
}

alias PaginationBefore = {
  @doc("A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.")
  @query("before") paginationBefore?: string;
};

alias PaginationAfter = {
  @doc("A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.")
  @query("after") paginationAfter?: string,
};

alias SortDirection = {
  @doc("The direction to sort the results by.")
  @query("direction") direction?: SortOrder = SortOrder.Descending,
};

enum SortOrder {
  Ascending: "asc",
  Descending: "desc"
}

@minValue(1)
@maxValue(100)
scalar perPageValue extends int32;

@OpenAPI.oneOf
union StringOrStrings {
  string,
  string[];
}

@maxItems(1000)
model MaxAdvisoryAffects is string[];

@OpenAPI.oneOf
union AdvisoryAffects {
  string,
  MaxAdvisoryAffects;
}

enum AdvisoryListSort {
  Updated: "updated",
  Published: "published"
}

enum AdvisoryType {
  Reviewed: "reviewed",
  Malware: "malware",
  Unreviewed: "unreviewed",
}

enum AdvisoryEcosystem {
  Actions: "actions",
  Composer: "composer",
  Erlang: "erlang",
  Go: "go",
  Maven: "maven",
  Npm: "npm",
  NuGet: "nuget",
  Other: "other",
  Pip: "pip",
  Pub: "pub",
  RubyGems: "rubygems",
  Rust: "rust"
}

enum AdvisorySeverity {
  Unknown: "unknown",
  Low: "low",
  Moderate: "moderate",
  High: "high",
  Critical: "critical"
}
