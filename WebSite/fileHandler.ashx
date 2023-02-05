<%@ WebHandler Language="C#" Class="fileHandler" %>

using System;
using System.Web;
using System.IO;

public class fileHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
        try
        {
            HttpPostedFile file = context.Request.Files[0];
            string id = context.Request.Params[0];
            string type = context.Request.Params[1];
            string dirFullPath;
            if (type == "Visitor")
            {
                dirFullPath = HttpContext.Current.Server.MapPath("~/BusinessCommunityDetails/");
            }
            else
            {
                dirFullPath = HttpContext.Current.Server.MapPath("~/BusinessCommunityDetails/");
            }
            string[] files;
            int numFiles;
            files = System.IO.Directory.GetFiles(dirFullPath);
            numFiles = files.Length;
            numFiles = numFiles + 1;
            string str_image = "";


            //        foreach (string s in context.Request.Files)
            //{

            string fileName = file.FileName;
            string fileExtension = file.ContentType;
            if (!string.IsNullOrEmpty(fileName))
            {
                fileExtension = Path.GetExtension(fileName);
                str_image = id + fileExtension;
                string pathToSave_100;
                if (type == "Visitor")
                {
                    pathToSave_100 = HttpContext.Current.Server.MapPath("~/BusinessCommunityDetails/") + str_image;
                }
                else
                {
                    pathToSave_100 = HttpContext.Current.Server.MapPath("~/BusinessCommunityDetails/") + str_image;
                }
                file.SaveAs(pathToSave_100);

            }
            //            }
            //  database record update logic here  ()

            context.Response.Write(str_image);
        }
        catch (Exception ac)
        {


        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}