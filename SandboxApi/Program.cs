var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var currentNS = Environment.GetEnvironmentVariable("KUBERNETES_NAMESPACE");
var sandboxManager = new SandboxManager();

app.MapGet("/", () => $"Hello World from namespace '{currentNS}'");
app.MapGet("/create/{nsName}", (string nsName) => sandboxManager.CreateNewEnvironment(nsName));

app.Run();
