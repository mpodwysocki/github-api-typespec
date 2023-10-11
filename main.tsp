import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "./advisories";
import "./root";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
  title: "GitHub's v3 REST API.",
  version: "2022-11-28",
})
@server("https://api.github.com", "GitHub API")
@doc("The GitHub API is a REST API used to access GitHub's features.")
namespace GitHub;

