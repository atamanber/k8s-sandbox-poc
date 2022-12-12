var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var k8s_ns = Environment.GetEnvironmentVariable("KUBERNETES_NAMESPACE");

app.MapGet("/", () => $"Welcome to {k8s_ns}");

app.Run();
