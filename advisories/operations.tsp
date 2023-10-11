import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace GitHub;

@route("/advisories")
namespace Advisories {
  @get
  @tag("ecurity-advisories")
  @summary("List global security advisories.")
  @doc("Lists all global security advisories that match the specified parameters. If no other parameters are defined, the request will return only GitHub-reviewed advisories that are not malware.\n\nBy default, all responses will exclude advisories for malware, because malware are not standard vulnerabilities. To list advisories for malware, you must include the `type` parameter in your request, with the value `malware`. For more information about the different types of security advisories, see \"[About the GitHub Advisory database](https://docs.github.com/code-security/security-advisories/global-security-advisories/about-the-github-advisory-database#about-types-of-security-advisories).\"")
  op list(
    @doc("If specified, only advisories with this GHSA (GitHub Security Advisory) identifier will be returned.")
    @query("ghsa_id") ghsaId?: string,

    @doc("If specified, only advisories of this type will be returned. By default, a request with no other parameters defined will only return reviewed advisories that are not malware.")
    @query type?: AdvisoryType = AdvisoryType.Reviewed,

    @doc("If specified, only advisories with this CVE (Common Vulnerabilities and Exposures) identifier will be returned.")
    @query("cve_id") cveId?: string,

    @doc("If specified, only advisories for these ecosystems will be returned.")
    @query ecosystem?: AdvisoryEcosystem,

    @doc("If specified, only advisories with these severities will be returned.")
    @query severity?: AdvisorySeverity,

    @doc("If specified, only advisories with these Common Weakness Enumerations (CWEs) will be returned.\n\nExample: `cwes=79,284,22` or `cwes[]=79&cwes[]=284&cwes[]=22`")
    @query cwes?: StringOrStrings,

    @doc("Whether to only return advisories that have been withdrawn.")
    @query("is_withdrawn") isWithdrawn?: boolean,

    @doc("If specified, only return advisories that affect any of `package` or `package@version`. A maximum of 1000 packages can be specified.\nIf the query parameter causes the URL to exceed the maximum URL length supported by your client, you must specify fewer packages.\n\nExample: `affects=package1,package2@1.0.0,package3@^2.0.0` or `affects[]=package1&affects[]=package2@1.0.0`")
    @query affects?: AdvisoryAffects,

    @doc("If specified, only return advisories that were published on a date or date range.\n\nFor more information on the syntax of the date range, see \"[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates).\"")
    @query published?: string,

    @doc("If specified, only return advisories that were updated on a date or date range.\n\nFor more information on the syntax of the date range, see \"[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates).\"")
    @query updated?: string,

    @doc("If specified, only show advisories that were updated or published on a date or date range.\n\nFor more information on the syntax of the date range, see \"[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates).\"")
    @query modified?: string,

    @doc("The number of results per page (max 100).")
    @query("per_page") perPage: perPageValue = 30,

    @doc("The property to sort the results by.")
    @query sort?: AdvisoryListSort = AdvisoryListSort.Published,

    ...PaginationBefore,
    ...PaginationAfter,
    ...SortDirection,
  ): {
    @statusCode statusCode: 200;
    @body body: GlobalAdvisory[];
  };
}
