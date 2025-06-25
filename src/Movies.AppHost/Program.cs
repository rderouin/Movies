using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Gremlin.Net.Driver;

var builder = DistributedApplication.CreateBuilder(args);

// Replace with the correct method to add a Docker container, e.g. AddContainer if available
// If using the .NET Aspire Distributed Application Toolkit, you may need to use AddContainer instead of AddDockerContainer
var gremlin = builder.AddContainer("gremlin-server", "tinkerpop/gremlin-server:3.7.0")
    .WithEndpoint(8182, name: "gremlin")
    .WithEnvironment("GREMLIN__HOST", "gremlin-server")
    .WithEnvironment("GREMLIN__PORT", "8182");

builder.AddProject<Projects.Movies_Service>("Movies.Service")
    .WithEnvironment("GREMLIN__HOST", "gremlin-server")
    .WithEnvironment("GREMLIN__PORT", "8182");


var portString = builder.Configuration["Gremlin:port"];
if (!int.TryParse(portString, out var port))
{
    // Handle the error, e.g., set a default or throw an exception
    port = 8182; // Default port for Gremlin
}
var host = builder.Configuration["gremlin:host"] ?? "localhost";
var gremlinServer = new GremlinServer(host, port);

builder.Build().Run();

