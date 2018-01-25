<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NotLoggedIn.aspx.cs" Inherits="ErrorPages_NotLoggedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>You have to be logged in to access this page!</h1>
        <p>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
        </p>
    </div>
    </form>
</body>
</html>
