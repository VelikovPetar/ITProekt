using Newtonsoft.Json.Serialization;
using System;
using System.Web.Http;
using System.Web.Routing;

public class Global : System.Web.HttpApplication
{
    public Global()
    {

    }

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        // Map the http route to the controller
        RouteTable.Routes.MapHttpRoute(
            name: "DefaultApi",
            routeTemplate: "api/{controller}/{id}",
            defaults: new { id = System.Web.Http.RouteParameter.Optional }
            );
        // This removes the backing field syntax when serializing the models to JSON
        var serializerSettings = GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings;
        var contractResolver = (DefaultContractResolver)serializerSettings.ContractResolver;
        contractResolver.IgnoreSerializableAttribute = true;
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
}