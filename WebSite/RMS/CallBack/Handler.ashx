<%@ WebHandler Language="C#" Class="Handler" %>
using System;
using System.Configuration;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;
public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
              Int32 empno;
        if (context.Request.QueryString["EID"] != null)
            empno = Convert.ToInt32(context.Request.QueryString["EID"]);
        else
            throw new ArgumentException("No parameter specified");

        context.Response.ContentType = "image/jpeg";
        Stream strm = ShowEmpImage(empno);
        byte[] buffer = new byte[4096];
        int byteSeq = strm.Read(buffer, 0, 4096);

        while (byteSeq > 0)
        {
            context.Response.OutputStream.Write(buffer, 0, byteSeq);
            byteSeq = strm.Read(buffer, 0, 4096);
        }       
    }

    public Stream ShowEmpImage(int empno)
    {
        string conn = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        string sql = "SELECT NewPhoto FROM Employee WHERE EID =58";// + empno;
        SqlCommand cmd = new SqlCommand(sql, connection);
        cmd.CommandType = CommandType.Text;
       // cmd.Parameters.AddWithValue("@ID", empno);
        connection.Open();
        object img = cmd.ExecuteScalar();
        try
        {
            return new MemoryStream((byte[])img);
        }
        catch
        {
            return null;
        }
        finally
        {
            connection.Close();
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}