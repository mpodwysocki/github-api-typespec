import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace GitHub;

@route("/")
namespace Root {
  @get
  @tag("meta")
  @summary("GitHub API Root")
  @doc("Get Hypermedia links to resources accessible in GitHub's REST API.")
  op read(): {
    @statusCode statusCode: 200;
    @body root: RootResponse;
  };
}
