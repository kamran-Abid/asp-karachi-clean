using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;



using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Drawing;
using System.IO;
using System.Drawing;
using System.Text.RegularExpressions;

public partial class VahicleRegistration : System.Web.UI.Page
{
     string image_path = "";
    int imageflagMember = 0;

    int imageflagDriver1 = 0;
    int imageflagDriver2 = 0;
    int imageflagDriver3 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT [Designation_ID],[designation] from  [HR_Designation] where is_deleted=1 order by designation ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds);
            ddlRank.DataSource = ds;
            ddlRank.DataValueField = "Designation_ID";
            ddlRank.DataTextField = "designation";
            ddlRank.DataBind();
            ddlRank.Items.Insert(0, new ListItem("-- Select --", "0"));

        }
    }


    protected void btn_upload_Click(object sender, EventArgs e)
    {
        imageflagMember = 1;

        if (!FileUpload_image.HasFile)
        {
           // Alert.Show("No file for uploading");
            string script = "<script type = 'text/javascript'>alert('No file for uploading');</script>";
            return;
        }
        if (FileUpload_image.HasFile)
        {
            //string imagetype = FileUpload_image.PostedFile.ContentType;
            string[] acceptedTypes = new string[] 
            { 
                "image/bmp", 
                "image/jpeg", 
                "image/tiff", 
                "image/gif", 
                "image/png" 
                     };

            if (!acceptedTypes.Contains(FileUpload_image.PostedFile.ContentType))
            {
                //Alert.Show("This is not image file");
                string script = "<script type = 'text/javascript'>alert('This is not image file');</script>";
                return;
            }
            Bitmap image = ResizeImage(FileUpload_image.PostedFile.InputStream, 84, 118);
            string imagename = Guid.NewGuid().ToString();
            image.Save(Server.MapPath("~/V Pictures/") + imagename + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
         img_Member.ImageUrl = "~/V Pictures/" + imagename + ".jpg";
            image_path = "~/V Pictures/" + imagename + ".jpg";
        }

    }

    private Bitmap ResizeImage(Stream streamImage, int maxWidth, int maxHeight)
    {
        Bitmap originalImage = new Bitmap(streamImage);
        int newWidth = originalImage.Width;
        int newHeight = originalImage.Height;
        double aspectRatio = (double)originalImage.Width / (double)originalImage.Height;

        if (aspectRatio <= 1 && originalImage.Width > maxWidth)
        {
            newWidth = maxWidth;
            newHeight = (int)Math.Round(newWidth / aspectRatio);
        }
        else if (aspectRatio > 1 && originalImage.Height > maxHeight)
        {
            newHeight = maxHeight;
            newWidth = (int)Math.Round(newHeight * aspectRatio);
        }

        return new Bitmap(originalImage, newWidth, newHeight);
    }
 
    protected void btn_remove_Click(object sender, EventArgs e)
    {
        img_Member.ImageUrl = "~/V Pictures/noImageAvailable.jpg";
    }
    protected void btnUploadPictureDriver1_Click(object sender, EventArgs e)
    {
        imageflagDriver1 = 1;

        if (!FileUploadDriver1.HasFile)
        {
            // Alert.Show("No file for uploading");
            string script = "<script type = 'text/javascript'>alert('No file for uploading');</script>";
            return;
        }
        if (FileUploadDriver1.HasFile)
        {
            //string imagetype = FileUpload_image.PostedFile.ContentType;
            string[] acceptedTypes = new string[] 
            { 
                "image/bmp", 
                "image/jpeg", 
                "image/tiff", 
                "image/gif", 
                "image/png" 
                     };

            if (!acceptedTypes.Contains(FileUploadDriver1.PostedFile.ContentType))
            {
                //Alert.Show("This is not image file");
                string script = "<script type = 'text/javascript'>alert('This is not image file');</script>";
                return;
            }
            Bitmap image = ResizeImage(FileUploadDriver1.PostedFile.InputStream, 84, 118);
            string imagename = Guid.NewGuid().ToString();
            image.Save(Server.MapPath("~/Driver Pictures/") + imagename + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            img_driver1.ImageUrl = "~/Driver Pictures/" + imagename + ".jpg";
            image_path = "~/Driver Pictures/" + imagename + ".jpg";
        }
    }
    protected void btnUploadPictureDriver2_Click(object sender, EventArgs e)
    {

        imageflagDriver2 = 1;

        if (!FileUploadDriver2.HasFile)
        {
            // Alert.Show("No file for uploading");
            string script = "<script type = 'text/javascript'>alert('No file for uploading');</script>";
            return;
        }
        if (FileUploadDriver2.HasFile)
        {
            //string imagetype = FileUpload_image.PostedFile.ContentType;
            string[] acceptedTypes = new string[] 
            { 
                "image/bmp", 
                "image/jpeg", 
                "image/tiff", 
                "image/gif", 
                "image/png" 
                     };

            if (!acceptedTypes.Contains(FileUploadDriver2.PostedFile.ContentType))
            {
                //Alert.Show("This is not image file");
                string script = "<script type = 'text/javascript'>alert('This is not image file');</script>";
                return;
            }
            Bitmap image = ResizeImage(FileUploadDriver2.PostedFile.InputStream, 84, 118);
            string imagename = Guid.NewGuid().ToString();
            image.Save(Server.MapPath("~/Driver Pictures/") + imagename + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            img_driver2.ImageUrl = "~/Driver Pictures/" + imagename + ".jpg";
            image_path = "~/Driver Pictures/" + imagename + ".jpg";
        }
    }
    protected void btnUploadPictureDriver3_Click(object sender, EventArgs e)
    {

        imageflagDriver3 = 1;

        if (!FileUploadDriver3.HasFile)
        {
            // Alert.Show("No file for uploading");
            string script = "<script type = 'text/javascript'>alert('No file for uploading');</script>";
            return;
        }
        if (FileUploadDriver3.HasFile)
        {
            //string imagetype = FileUpload_image.PostedFile.ContentType;
            string[] acceptedTypes = new string[] 
            { 
                "image/bmp", 
                "image/jpeg", 
                "image/tiff", 
                "image/gif", 
                "image/png" 
                     };

            if (!acceptedTypes.Contains(FileUploadDriver3.PostedFile.ContentType))
            {
                //Alert.Show("This is not image file");
                string script = "<script type = 'text/javascript'>alert('This is not image file');</script>";
                return;
            }
            Bitmap image = ResizeImage(FileUploadDriver3.PostedFile.InputStream, 84, 118);
            string imagename = Guid.NewGuid().ToString();
            image.Save(Server.MapPath("~/Driver Pictures/") + imagename + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            img_driver3.ImageUrl = "~/Driver Pictures/" + imagename + ".jpg";
            image_path = "~/Driver Pictures/" + imagename + ".jpg";
        }
    }
}