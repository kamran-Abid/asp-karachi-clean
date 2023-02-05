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


using System.IO;
using System.Web.Services;
using System.Text;
using System.Diagnostics;
public partial class VisitorRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT [ID],[HOST_NAME] from  [host] where is_deleted=1 order by HOST_NAME ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds);
            ddlPlaceOfVisit.DataSource = ds;
            ddlPlaceOfVisit.DataValueField = "ID";
            ddlPlaceOfVisit.DataTextField = "HOST_NAME";
            ddlPlaceOfVisit.DataBind();
            ddlPlaceOfVisit.Items.Insert(0, new ListItem("-- Select --", "0"));

        }
        if (!this.IsPostBack)
        {
            if (Request.InputStream.Length > 0)
            {
                using (StreamReader reader = new StreamReader(Request.InputStream))
                {
                   // Guid sd = new Guid();

                    string hexString = Server.UrlEncode(reader.ReadToEnd());
                   // string imageName = sd.ToString();// DateTime.Now.ToString("dd-MM-yy hh-mm-ss");
                  

                    byte[] gb = Guid.NewGuid().ToByteArray();
                    

                    long name = BitConverter.ToInt64(gb, 0);
                    txtEngName.Text = name.ToString();
                    string imagePath = string.Format("~/VMS/Captures/{0}.png", name);
                    File.WriteAllBytes(Server.MapPath(imagePath), ConvertHexToBytes(hexString));
                    Session["CapturedImage"] = ResolveUrl(imagePath);
                }
            }
        }
    }
    private static byte[] ConvertHexToBytes(string hex)
    {
        byte[] bytes = new byte[hex.Length / 2];
        for (int i = 0; i < hex.Length; i += 2)
        {
            bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
        }
        return bytes;
    }

    [WebMethod(EnableSession = true)]
    public static string GetCapturedImage()
    {
        string url = HttpContext.Current.Session["CapturedImage"].ToString();
        HttpContext.Current.Session["CapturedImage"] = null;
        return url;
    }

    [WebMethod]
    public static string MyMethod(string barcodeString)
                                                                                                                  
    {

                                                                                                                                                              
              
        string result = "";
        ConvertString cS = new ConvertString();

        result += cS.ConvertToUnicodeold1(barcodeString + "\r");

        return result;



    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT top 1  [ID] from [visitor] order by [ID] desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds);
            dt = ds.Tables[0];
            string value = dt.Rows[0]["ID"].ToString();

            string appLocation = @"E:\Debug\VMSControls.exe";
            Process test = new Process();
            test.StartInfo.FileName = appLocation;
            test.StartInfo.Arguments = value;
            test.Start();

        }
       
    }
}
class ConvertString
{


    public string ConvertToUnicodeold1(string str2)
    {
        ConvertString cs1 = new ConvertString();
        string str4 = "";
        string str1 = cs1.converttohex(str2);
        char char1 = '\0';

        string[] str3 = str1.Split(" ".ToCharArray());

        for (int i = 0; i <= str3.GetUpperBound(0); i++)
            try
            {
                if (str3[i + 1] == "06")
                {
                    str4 = cs1.checkUnicode(str3[i + 1] + str3[i], str4);
                    i++;
                }
                else
                {
                    char1 = (char)Int16.Parse(str3[i].ToString(), System.Globalization.NumberStyles.AllowHexSpecifier);
                    str4 = str4 + char1;
                    //str4 = str4 + char.ToString((char)int.Parse(str3[i], System.Globalization.NumberStyles ));// cs1.checkUnicode(str3[i], str4);
                }
            }
            catch (Exception ex) { }
        return str4;
    }

    public string checkUnicode(string str2, string sb)
    {
        str2 = str2.ToUpper();
        //string sb = str3;

        switch (str2)
        {
            //            case "Acronym":
            //                sb = sb + str2;
            //                break;
            case "06AF":
                sb = sb + "\u06AF";
                //sb.append();
                break;

            case "062D":
                sb = sb + "\u062D";
                break;

            case "20":
                sb = sb + "\u0020";
                break;

            case "0624":
                sb = sb + "\u0624";
                break;

            case "060D":
                sb = sb + "\u060D";
                break;

            case "0620":
                sb = sb + "\u0620";
                break;
            case "06A6":
                sb = sb + "\u06CC";
                break;
            case "060c":
                sb = sb + "\u060c";
                break;
            case "0693":
                sb = sb + "\u0693";
                break;
            case "0658":
                sb = sb + "\u0658";
                break;

            case "062E":
                sb = sb + "\u062E";
                break;

            case "0622":
                sb = sb + "\u0622";
                //sb.append();
                break;

            case "0627":
                sb = sb + "\u0627";
                //sb.append();
                break;

            case "0613":
                sb = sb + "\u0613";
                //sb.append();
                break;

            case "0628":
                sb = sb + "\u0628";
                //sb.append();
                break;

            case "062B":
                sb = sb + "\u062B";
                //sb.append();
                break;

            case "0686":
                sb = sb + "\u0686";
                //sb.append();
                break;

            case "0688":
                sb = sb + "\u0688";
                //sb.append();
                break;

            case "062F":
                sb = sb + "\u062F";
                //sb.append();
                break;

            case "0610":
                sb = sb + "\u0610";
                //sb.append();
                break;

            case "0639":
                sb = sb + "\u0639";
                //sb.append();
                break;

            case "0641":
                sb = sb + "\u0641";
                //sb.append();
                break;

            case "063A":
                sb = sb + "\u063A";
                //sb.append();
                break;



            //            case "2D":
            //              sb = sb + "\u062D";
            //sb.append();
            //            break;

            case "06BE":
                sb = sb + "\u06BE";
                //sb.append();
                break;

            case "06CC":
                sb = sb + "\u06CC";
                //sb.append();
                break;

            case "0636":
                sb = sb + "\u0636";
                //sb.append();
                break;

            case "062C":
                sb = sb + "\u062C";
                //sb.append();
                break;

            case "0643":
                sb = sb + "\u0643";
                //sb.append();
                break;

            case "0612":
                sb = sb + "\u0612";
                //sb.append();
                break;

            case "0644":
                sb = sb + "\u0644";
                //sb.append();
                break;

            case "0645":
                sb = sb + "\u0645";
                //sb.append();
                break;

            case "06BA":
                sb = sb + "\u06BA";
                //sb.append();
                break;

            case "0646":
                sb = sb + "\u0646";
                //sb.append();
                break;

            case "0629":
                sb = sb + "\u0629";
                //sb.append();
                break;

            case "06A9":
                sb = sb + "\u06A9";
                //sb.append();
                break;

            case "06C1":
                sb = sb + "\u06C1";
                //sb.append();
                break;

            //case "45":
            //    sb.Append("\u0645";
            //    break;

            case "067E":
                sb = sb + "\u067E";
                //sb.append();
                break;

            case "0642":
                sb = sb + "\u0642";
                //sb.append();
                break;

            case "0691":
                sb = sb + "\u0691";
                //sb.append();
                break;

            case "0631":
                sb = sb + "\u0631";
                //sb.append();
                break;

            case "0635":
                sb = sb + "\u0635";
                //sb.append();
                break;

            case "0633":
                sb = sb + "\u0633";
                //sb.append();
                break;

            case "0679":
                sb = sb + "\u0679";
                //sb.append();
                break;

            case "062A":
                sb = sb + "\u062A";
                //sb.append();
                break;

            case "0621":
                sb = sb + "\u0621";
                //sb.append();
                break;

            case "0638":
                sb = sb + "\u0638";
                //sb.append();
                break;

            case "0637":
                sb = sb + "\u0637";
                //sb.append();
                break;

            //case "48":
            //    sb.Append("\\u0635\u0644\u0649\u0020\u0627\u0644\u0644\u0647\u0020\u0639\u0644\u064a\u0647\u0020\u0648\u0633\u0644\u0645";
            //    break;

            case "0648":
                sb = sb + "\u0648";
                //sb.append();
                break;

            case "0698":
                sb = sb + "\u0698";
                //sb.append();
                break;

            case "0634":
                sb = sb + "\u0634";
                //sb.append();
                break;

            case "06D2":
                sb = sb + "\u06D2";
                //sb.append();
                break;

            case "0630":
                sb = sb + "\u0630";
                //sb.append();
                break;

            case "0632":
                sb = sb + "\u0632";
                //sb = sb + "\u0632";
                //sb.append();
                break;

            case "0660":
                sb = sb + "\u0660";
                //sb.append();
                break;

            case "0661":
                sb = sb + "\u0661";
                //sb.append();
                break;

            case "0662":
                sb = sb + "\u0662";
                //sb.append();
                break;

            case "0663":
                sb = sb + "\u0663";
                //sb.append();
                break;

            case "0664":
                sb = sb + "\u0664";
                //sb.append();
                break;

            case "0665":
                sb = sb + "\u0665";
                //sb.append();
                break;

            case "0666":
                sb = sb + "\u0666";
                //sb.append();
                break;

            case "0667":
                sb = sb + "\u0667";
                //sb.append();
                break;

            case "0668":
                sb = sb + "\u0668";
                //sb.append();
                break;

            case "0669":
                sb = sb + "\u0669";
                //sb.append();
                break;
            case "0670":
                sb = sb + "\u0670";
                //sb.append();
                break;
            case "0626":
                sb = sb + "\u0626";
                //sb.append();
                break;
            case "060C":
                sb = sb + " \u060C";
                //sb.append();
                break;

            case "06D4":
                sb = sb + "\u06D4";
                //sb.append();
                break;

            //case "0C":
            //    sb.Append("\u060c";
            //    break;

            case "061F":
                sb = sb + "\u061F";
                //sb.append();
                break;

            case "0602":
                sb = sb + "\u0602";
                //sb.append();
                break;

            case "061B":
                sb = sb + "\u061B";
                //sb.append();
                break;

            case "067B":
                sb = sb + "\u067B";
                //sb.append();
                break;

            case "067D":
                sb = sb + "\u067D";
                //sb.append();
                break;
            case "0649":
                sb = sb + "\u0649";
                break;
            case "0692":
                //sb = sb + "\u0692";
                sb = sb + "\u0627";
                break;
            case "06A1":
                sb = sb + "\u06A1";
                break;
            //case "58":
            //   sb = sb + "\u0058";
            //   break;
            default:
                //sb = sb + "\u061F";
                //sb = sb + (char)Int32.Parse(str2, System.Globalization.NumberStyles.AllowHexSpecifier);
                sb = sb + "(" + str2 + ")";
                break;
        }


        return sb;
    }
    public string converttohex(string normalstring)
    {
        byte[] ba = Encoding.Default.GetBytes(normalstring);
        var hexString = BitConverter.ToString(ba);
        hexString = hexString.Replace("-", " ");
        return hexString;
    }


}



