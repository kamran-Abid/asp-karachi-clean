<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vms-loginpage.aspx.cs" Inherits="vms_loginpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VMS-LoginPage</title>
      <link href="css/style_new.css" rel="stylesheet" />

</head>
<body>
  
<div id="login">
  <h1 id="header">Login</h1>
  <form id="form1" runat="server">
    <input type="text" placeholder="Username" id="txtUserName" runat="server" /><br />
    <input type="password" placeholder="Password" id="txtPassword"  runat="server" /><br />
   <%-- <input type="button" id="Button1" value="Login"   runat="server" />--%>

       <asp:Button ID="Button1" CssClass="button" runat="server" Text="Login" OnClick="btnLogin_Click" />
  </form>
</div>
     <asp:Label ID="lblErrorMessage" runat="server" style="color:red;font-size:14px; font-weight:bold;"></asp:Label>
        <%--<script src="js/index.js"></script>--%>

    
</body>
</html>

